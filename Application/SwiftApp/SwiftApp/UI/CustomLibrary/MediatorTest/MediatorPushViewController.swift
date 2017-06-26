//
//  MediatorPushViewController.swift
//  SwiftApp
//
//  Created by Halin Lee on 6/23/17.
//  Copyright © 2017 Halin. All rights reserved.
//

import Foundation
import AppUIKit
import Fundamental
import UIKit

class MediatorPushViewController:UIViewController, ConfigurableViewController ,DesignableViewController{
    
    static let TAG = NSStringFromClass(MediatorSheetViewController.self)
    static var index = 1
    let currentIndex:Int
    
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        currentIndex = MediatorPushViewController.index
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var viewHolder:MediatorViewHolder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        viewHolder = MediatorViewHolder(parent:self.view)
        bind()
        MediatorPushViewController.index += 1
    }
    
    
    func bind(){
        self.viewHolder.mediatorPushButton
            .reactive.controlEvents(UIControlEvents.touchUpInside)
            .observe{
                [weak self] event in
                switch event {
                case .value:
                    _ = Mediator.instance.present(controllerClass: MediatorPushViewController.self, currentVC: self!, param: [MediatorKeys.FROM:self!.currentIndex])
                default:
                    return
                }
        }
        
        self.viewHolder.mediatorPresentButton
            .reactive.controlEvents(UIControlEvents.touchUpInside)
            .observe{
                [weak self] event in
                switch event {
                case .value:
                    _ = Mediator.instance.present(controllerClass: MediatorPresentViewController.self, currentVC: self!, param: [MediatorKeys.FROM:self!.currentIndex])
                    
                default:
                    return
                }
        }
        
        self.viewHolder.mediatorPopButton
            .reactive.controlEvents(UIControlEvents.touchUpInside)
            .observe{
                [weak self] event in
                switch event {
                case .value:
                    _ = Mediator.instance.pop(currentVC: self!, param: [MediatorKeys.FROM:self!.currentIndex])
                default:
                    return
                }
        }
        
        self.viewHolder.mediatorPopToPushButton
            .reactive.controlEvents(UIControlEvents.touchUpInside)
            .observe{
                [weak self] event in
                switch event {
                case .value:
                    _ = Mediator.instance.popTo(class: MediatorPushViewController.self, currentVC: self!, param: [MediatorKeys.FROM:self!.currentIndex])
                default:
                    return
                }
        }
        
        self.viewHolder.mediatorPopToPresentButton
            .reactive.controlEvents(UIControlEvents.touchUpInside)
            .observe{
                [weak self] event in
                switch event {
                case .value:
                    _ = Mediator.instance.popTo(class: MediatorPresentViewController.self, currentVC: self!, param: [MediatorKeys.FROM:self!.currentIndex])
                default:
                    return
                }
        }
        
        self.viewHolder.mediatorPopToRoot
            .reactive.controlEvents(UIControlEvents.touchUpInside)
            .observe{
                [weak self] event in
                switch event {
                case .value:
                    _ = Mediator.instance.popTo(class: MainViewController.self, currentVC: self!, param: [MediatorKeys.FROM:self!.currentIndex])
                default:
                    return
                }
        }
        
        self.viewHolder.pushSheetButton
            .reactive.controlEvents(UIControlEvents.touchUpInside)
            .observe{
                [weak self] event in
                switch event {
                case .value:
                    self!.navigationController?.pushViewController(MediatorSheetViewController(), animated: true)
                default:
                    return
                }
        }
        self.viewHolder.presentSheetButton
            .reactive.controlEvents(UIControlEvents.touchUpInside)
            .observe{
                [weak self] event in
                switch event {
                case .value:
                    
                    self?.present(MediatorSheetViewController(), animated: true, completion: nil)
                default:
                    return
                }
        }
        self.viewHolder.popButton
            .reactive.controlEvents(UIControlEvents.touchUpInside)
            .observe{
                [weak self] event in
                switch event {
                case .value:
                    self!.navigationController?.popViewController(animated: true)
                default:
                    return
                }
        }
        self.viewHolder.dismissButton
            .reactive.controlEvents(UIControlEvents.touchUpInside)
            .observe{
                [weak self] event in
                switch event {
                case .value:
                    self?.dismiss(animated: true, completion: nil)
                default:
                    return
                }
        }
    }
    
    
    func viewControllerPresentType() -> ViewControllerPresentType{
        return .PresentTypePush
    }
    
    func isHideNavigationBar() -> Bool {
        return false
    }
    
    func receiveStartParam(parameters:Dictionary<String, Any>){
        print("receiveStartParam\(parameters)");
    }
    
    func receivePopParam(parameters:Dictionary<String, Any>,fromChild:Bool){
        print("popWithParam\(parameters)");
    }
    
}
