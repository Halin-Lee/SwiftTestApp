//
//  HelloWorldViewController.swift
//  SwiftApp
//
//  Created by Halin Lee on 6/23/17.
//  Copyright © 2017 Halin. All rights reserved.
//

import Foundation
import UIKit
import Fundamental

class HelloWorldViewController: UIViewController,ConfigurableViewController,DesignableViewController {
    
 
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
    }
    
    func viewControllerPresentType() -> ViewControllerPresentType{
        return ViewControllerPresentType.push
    }
    
    func isHideNavigationBar() -> Bool {
        return false
    }
    
    func receiveStartParam(parameters:Dictionary<String, Any>){}
    
    func popWithParam(parameters:Dictionary<String, Any>){}


    
}
