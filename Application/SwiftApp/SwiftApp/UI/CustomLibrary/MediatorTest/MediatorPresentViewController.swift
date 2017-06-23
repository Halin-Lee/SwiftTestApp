//
//  MediatorPresentViewController.swift
//  SwiftApp
//
//  Created by Halin Lee on 6/23/17.
//  Copyright © 2017 Halin. All rights reserved.
//

import Foundation
import AppUIKit
import Fundamental
import UIKit

class MediatorPresentViewController:UIViewController, ConfigurableViewController,DesignableViewController {
    
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
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
    }
    
    
    func bind(){
        self.viewHolder.pushButton
            .reactive.controlEvents(UIControlEvents.touchUpInside)
            .observe{
                event in
                switch event {
                case .value:
                    _ = Mediator.instance.present(viewControllerClass: MediatorPushViewController.self,param:Dictionary());
                default:
                    return
                }
        }
        
        self.viewHolder.presentButton
            .reactive.controlEvents(UIControlEvents.touchUpInside)
            .observe{
                event in
                switch event {
                case .value:
                    _ = Mediator.instance.present(viewControllerClass: MediatorPresentViewController.self,param:Dictionary());
                default:
                    return
                }
        }
        
        self.viewHolder.popButton
            .reactive.controlEvents(UIControlEvents.touchUpInside)
            .observe{
                event in
                switch event {
                case .value:
                    _ = Mediator.instance.pop(withParam: nil);
                default:
                    return
                }
        }
        
        self.viewHolder.popToPushButton
            .reactive.controlEvents(UIControlEvents.touchUpInside)
            .observe{
                event in
                switch event {
                case .value:
                    _ = Mediator.instance.popTo(viewController: MediatorPushViewController.self,param:Dictionary())
                default:
                    return
                }
        }
        
        self.viewHolder.popToPresentButton
            .reactive.controlEvents(UIControlEvents.touchUpInside)
            .observe{
                event in
                switch event {
                case .value:
                    _ = Mediator.instance.popTo(viewController: MediatorPresentViewController.self,param:Dictionary())
                default:
                    return
                }
        }
        
        self.viewHolder.popToRoot
            .reactive.controlEvents(UIControlEvents.touchUpInside)
            .observe{
                event in
                switch event {
                case .value:
                    _ = Mediator.instance.popTo(viewController: MainViewController.self,param:Dictionary())
                default:
                    return
                }
        }
        self.viewHolder.dismiss
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
        return .PresentTypePresent
    }
    
    func isHideNavigationBar() -> Bool {
        return false
    }
    
    func receiveStartParam(parameters:Dictionary<String, Any>){
        
    }
    
    func popWithParam(parameters:Dictionary<String, Any>){}
    
}
