//
//  Mediator.swift
//  Pods
//
//  Created by Halin Lee on 6/22/17.
//
//

import Foundation
import UIKit
import ReactiveCocoa

public class Mediator{
    
    static let TAG:String = NSStringFromClass(Mediator.self);
    
    public static let instance = Mediator()
    
    
    /// 回退表，保存VC的上个VC，当VC后退时，会自动带上参数
    var backDictionary = NSMapTable<UIViewController,UIViewController>.weakToWeakObjects()
    
    public required init() {
    }
    
    public func setup(rootVC:UIViewController) -> UINavigationController{
        
        let rootNav = UINavigationController(rootViewController:rootVC)
        self.observeVCAppear(controller: rootVC)
        return rootNav
    }
    
    
    /// 构造并显示一个VC
    ///
    /// - Parameters:
    ///   - cls: VC类
    ///   - param: 启动参数
    ///   - animated: 是否显示动画
    /// - Returns: 是否成功显示
    public func present(controllerClass cls:UIViewController.Type,currentVC:UIViewController, param:Dictionary<String, Any>? = nil, animated:Bool = true) -> Bool {
        let viewController = cls.init()
        return self.present(controller: viewController, currentVC: currentVC, param: param,animated:animated)
    }
    public func present(controller:UIViewController, currentVC:UIViewController, param:Dictionary<String, Any>? = nil, animated:Bool = true) -> Bool {
        
        //插入回退监听，用于配制navigation
        self.observeVCAppear(controller: controller)
        
        //如果可以接收回退，保存回退
        if currentVC is ConfigurableViewController {
            backDictionary.setObject(currentVC, forKey: controller)
        }
        
        var presentType = ViewControllerPresentType.PresentTypePush
        if controller is ConfigurableViewController {
            let configuarbleVC = controller as! ConfigurableViewController
            //设置参数，获得呈现方式
            if param != nil {
                configuarbleVC.receiveStartParam(parameters: param!)
            }
        }
        
        if controller is DesignableViewController {
            //配置展现方式
            let designableVC = controller as! DesignableViewController
            presentType = designableVC.viewControllerPresentType()
        }
        
        //寻找当前正在present的controller
        let rootController = UIApplication.shared.delegate!.window!?.rootViewController
        var topController = rootController
        while (topController!.presentedViewController != nil) {
            topController = topController!.presentedViewController
        }
        switch presentType {
        case .PresentTypePresent:
            //使用Present方式呈现VC
            let newNav = UINavigationController.init(rootViewController: controller)
            topController!.present(newNav, animated: animated, completion: nil)
        case .PresentTypePush:
            //使用Push方式呈现VC
            (topController as! UINavigationController).pushViewController(controller, animated: animated)
        }
        

        
        //某些动画可能导致主线程睡眠(比如cell点击动画),所以这里要主动唤醒主线程
        //http://stackoverflow.com/questions/21075540/presentviewcontrolleranimatedyes-view-will-not-appear-until-user-taps-again
        CFRunLoopWakeUp(CFRunLoopGetCurrent())
        
        Logger.log(tag: Mediator.TAG, message: "打开页面\(controller)")
        return true
    }
    
    
    /// 配制viewDidAppear监听，设置Navigation
    ///
    /// - Parameter controller: 需要配置的vc
    public func observeVCAppear(controller:UIViewController){
        
    controller.reactive
        .trigger(for:#selector(UIViewController.viewWillAppear(_:)))
        .observe{
            [weak controller] (event) in
            switch event{
            case .value(_):
                let nav = controller!.navigationController!   //这里如果使用weakself会导致无法释放，原因未知
                let isNavHidden = nav.isNavigationBarHidden
                
                //如果vc实现了 Designable 则由 Designable 决定是否显示nav，否则默认阴惨
                let isHideNavigationBar = controller is DesignableViewController ?
                    (controller as! DesignableViewController).isHideNavigationBar() : false;
                
                //当前显示状态与期望的状态不同，设置
                if isHideNavigationBar != isNavHidden {
                    nav.setNavigationBarHidden(isHideNavigationBar, animated: true);
                }
            default:
                return
            }
        }
    }
    
    
    public func pop(currentVC:UIViewController, param:Dictionary<String, Any>? = nil, animated:Bool = true) -> Bool{
        
        if currentVC.navigationController == nil {
            //没有nav，直接dismiss
            currentVC.presentingViewController!.dismiss(animated: animated, completion: nil)
        } else {
            let nav = currentVC.navigationController!
            if nav.viewControllers.count == 1 {
                //nav只剩下一个了，直接dismiss
                nav.presentingViewController!.dismiss(animated: animated, completion: nil)
            } else {
                //能pop，直接pop
                nav.popViewController(animated: animated)
            }
        }
        
        _ = self.sendPopParam(currentVC: currentVC,param: param, fromChild: true)
        
        Logger.log(tag: Mediator.TAG, message: "弹出页面\(currentVC)")
        return true
    }

    
    /// 会退到指定类
    ///
    /// - Parameters:
    ///   - cls: 类
    ///   - param: 参数
    ///   - animated: 是否显示动画
    /// - Returns: 是否成功
    public func popTo(class cls:UIViewController.Type,currentVC:UIViewController, param:Dictionary<String, Any>? = nil,animated:Bool = true) -> Bool {
        
        
        var targetVC:UIViewController?
        
        var popNav:UINavigationController?
        var popVC:UIViewController? = currentVC.navigationController != nil ? currentVC.navigationController : currentVC
        
        while targetVC == nil && popVC != nil{
            if (popVC!.isKind(of: cls) && popVC != currentVC){
                //找到指定类的VC且VC不是当前的VC，找到了可回退的VC
                targetVC = popVC
                break
            }

            if popVC is UINavigationController {
                for vc in (popVC as! UINavigationController).viewControllers.reversed(){
                    if (vc.isKind(of: cls) && vc != currentVC){
                        //找到指定类的VC且VC不是当前的VC，找到了可回退的VC
                        popNav = popVC as? UINavigationController
                        targetVC = vc
                        break
                    }
                }
            }
            popVC = popVC!.presentingViewController
        }
        
        
        if targetVC == nil {
            Logger.logE(tag: Mediator.TAG, message: "找不到可回退的VC \(cls)")
            return false
        }
        
        if popNav == nil {
            //没有nav，那么一定是用present的方式展现，所有直接dismiss就可以了
            targetVC!.dismiss(animated: animated, completion: nil)
        } else {
            //当前navgation不等于目标nav，需要先dismiss
            let needDismiss = currentVC.navigationController != popNav
            if needDismiss {
                popNav!.dismiss(animated: animated, completion: nil)
            }
            
            //整理popNav的队列
            var viewControllers = popNav!.viewControllers;
            for vc in viewControllers.reversed() {
                if (vc.isKind(of: cls) && vc != currentVC){
                    break
                }
                viewControllers.removeLast()
            }
            
            //设置
            if needDismiss && animated{
                //不需要动画，或者已经有dismiss动画，直接设置vc
                popNav!.viewControllers = viewControllers;
            } else {
                //需要动画，将当前的vc插入到nav，再播放pop动画
                viewControllers.append(currentVC)
                popNav!.viewControllers = viewControllers
                popNav!.popViewController(animated: true)
            }
        }
        
        _ = self.sendPopParam(currentVC: currentVC,param: param, fromChild: false)
        Logger.log(tag: Mediator.TAG, message: "从页面\(currentVC)返回页面\(String(describing: targetVC))")
        
        return true;
    }
    
    func sendPopParam(currentVC:UIViewController, param:Dictionary<String, Any>? = nil,fromChild:Bool) -> Bool {
        if param != nil {
            let lastVC:ConfigurableViewController? = backDictionary.object(forKey: currentVC) as? ConfigurableViewController;
            
            if lastVC == nil {
                Logger.logE(tag: Mediator.TAG, message: "VC已被弹出")
                return false
            }
            lastVC!.receivePopParam(parameters: param!, fromChild: fromChild)
        }
        return true
    }
    
}










