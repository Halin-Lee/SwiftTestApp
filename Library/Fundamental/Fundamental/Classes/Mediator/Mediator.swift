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
    
    public var navigationStack = Array<UINavigationController>();
    
    public required init() {
    }
    
    public func setup(rootViewController rootController:UIViewController) -> UINavigationController{
        
        if (navigationStack.count != 0) {
            Logger.logE(tag: Mediator.TAG, message: "异常,Mediator已被初始化过")
            navigationStack.removeAll()
        }
        
        let rootNav = UINavigationController(rootViewController:rootController)
        self.observeNavDismiss(targetNav:rootNav)
        navigationStack.append(rootNav)
        
        self.observeVCAppear(controller: rootController)
        
        return rootNav
    }
    
    
    /// 构造并显示一个VC
    ///
    /// - Parameters:
    ///   - cls: VC类
    ///   - param: 启动参数
    ///   - animated: 是否显示动画
    /// - Returns: 是否成功显示
    public func present(viewControllerClass cls:UIViewController.Type, param:Dictionary<String, Any>?, animated:Bool = true) -> Bool {
        let viewController = cls.init()
        return self.present(viewController: viewController, param: param, animated: animated)
    }
    public func present(viewController controller:UIViewController, param:Dictionary<String, Any>?, animated:Bool = true) -> Bool {
        
        //插入回退监听，用于配制navigation
        self.observeVCAppear(controller: controller)
        
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
        
        
        switch presentType {
        case .PresentTypePresent:
            //使用Present方式呈现VC
            let newNav = UINavigationController.init(rootViewController: controller)
            self.observeNavDismiss(targetNav:newNav)
            self.navigationStack.last?.present(newNav, animated: animated, completion: nil)
            self.navigationStack.append(newNav);
        case .PresentTypePush:
            //使用Push方式呈现VC
            self.navigationStack.last?.pushViewController(controller, animated: animated)
        }
        

        
        //某些动画可能导致主线程睡眠(比如cell点击动画),所以这里要主动唤醒主线程
        //http://stackoverflow.com/questions/21075540/presentviewcontrolleranimatedyes-view-will-not-appear-until-user-taps-again
        CFRunLoopWakeUp(CFRunLoopGetCurrent())
        
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
                let lastNav = Mediator.instance.navigationStack.last!   //这里如果使用weakself会导致无法释放，原因未知
                let isNavHidden = lastNav.isNavigationBarHidden
                
                //如果vc实现了 Designable 则由 Designable 决定是否显示nav，否则默认阴惨
                let isHideNavigationBar = controller is DesignableViewController ?
                    (controller as! DesignableViewController).isHideNavigationBar() : false;
                
                //当前显示状态与期望的状态不同，设置
                if isHideNavigationBar != isNavHidden {
                    lastNav.setNavigationBarHidden(isHideNavigationBar, animated: true);
                }
            default:
                return
            }
        }
    }
    
    /// 配制Nav的dismiss监听，避免手动调用dismiss时导致navigationStack对应不上的问题
    ///
    /// - Parameter controller: 需要配置的vc
    public func observeNavDismiss(targetNav:UINavigationController){
        
        targetNav.reactive
            .trigger(for:#selector(UIViewController.viewWillDisappear(_:)))
            .observe{
                [weak targetNav] (event) in
                switch event{
                case .value(_):
                    if targetNav!.isBeingDismissed {
                        //FIXME：处理对应不上的问题
                    }
                default:
                    return
                }
        }
        
    }
    
    public func pop(withParam param:Dictionary<String, Any>? = nil, animated:Bool = true) -> Bool{
        let lastNav = navigationStack.last!;
        
        if lastNav.viewControllers.count == 1 {
            //在nav的最后一个vc，用dismiss
            navigationStack.removeLast()
            lastNav.dismiss(animated: animated, completion: nil)
        } else {
            //不是最后一个vc，用pop
            lastNav.popViewController(animated: animated)
        }
        
        let lastVC = navigationStack.last!.topViewController!
        
        if lastVC is ConfigurableViewController && param != nil {
            (lastVC as! ConfigurableViewController).popWithParam(parameters: param!)
        }
        return true
    }

    
    /// 会退到指定类
    ///
    /// - Parameters:
    ///   - cls: 类
    ///   - param: 参数
    ///   - animated: 是否显示动画
    /// - Returns: 是否成功
    public func popTo(viewController cls:UIViewController.Type,  param:Dictionary<String, Any>? = nil,animated:Bool = true) -> Bool {
        var popNav:UINavigationController? = nil;
        
        let currentVC = navigationStack.last!.viewControllers.last!
        var targetVC:UIViewController!
        
        //遍历寻找会退目标VC
        for nav in navigationStack {
            for vc in nav.viewControllers.reversed(){
                if (vc.isKind(of: cls) && vc != currentVC){
                    //找到指定类的VC且VC不是当前的VC，找到了可回退的VC
                    popNav = nav
                    targetVC = vc
                    break
                }
            }
            if targetVC != nil{
                //已经找到，返回
                break
            }
        }
     
        if targetVC == nil {
            //不能后退
            Logger.log(tag: Mediator.TAG, message: "找不到可回退的VC \(cls)")
            return false
        }
     
        //能回退,回退
        
        //是否需要dismiss,当前的Nav不是目标Nav时需要回退
        let needDismiss = navigationStack.last != popNav
        //从navigationStack中移除
        while navigationStack.last != popNav {
            navigationStack.removeLast()
        }
        
        //dismiss动画
        if needDismiss {
            popNav?.dismiss(animated: animated, completion: nil)
        }
        
        //pop,修改Navigation的ViewControllers,将需要pop走的ViewController移除
        let lastNav = navigationStack.last!
        var viewControllers = lastNav.viewControllers;
        for vc in viewControllers.reversed() {
            if (vc.isKind(of: cls) && vc != currentVC){
                break
            }
            viewControllers.removeLast()
        }
        
        //播放pop动画
        if needDismiss && animated{
            //不需要动画，或者已经有dismiss动画，直接设置vc
            lastNav.viewControllers = viewControllers;
        } else {
            //需要动画，将当前的vc插入到nav，再播放pop动画
            viewControllers.append(currentVC)
            lastNav.viewControllers = viewControllers
            lastNav.popViewController(animated: true)
        }
        
        if targetVC is ConfigurableViewController && param != nil{
            (targetVC as! ConfigurableViewController).popWithParam(parameters: param!)
        }
        
        return true;
    }
}










