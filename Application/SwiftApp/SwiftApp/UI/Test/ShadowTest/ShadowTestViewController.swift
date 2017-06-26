//
//  ViewShadowTestViewController.swift
//  SwiftApp
//
//  Created by Halin Lee on 6/26/17.
//  Copyright © 2017 Halin. All rights reserved.
//

import Foundation

import Foundation
import UIKit
import Fundamental

class ShadowTestViewController: UIViewController,ConfigurableViewController,DesignableViewController {
    
    var viewHolder:ShadowTestViewHolder!
    
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        viewHolder = ShadowTestViewHolder(parent:self.view)
    }
    
    func viewControllerPresentType() -> ViewControllerPresentType{
        return ViewControllerPresentType.PresentTypePush
    }
    
    func isHideNavigationBar() -> Bool {
        return true
    }
    
    func receiveStartParam(parameters:Dictionary<String, Any>){}
    
    func popWithParam(parameters:Dictionary<String, Any>){}
    
    
    
}
