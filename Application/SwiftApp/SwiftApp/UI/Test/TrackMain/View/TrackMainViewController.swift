//
//  TrackMainViewController.swift
//  SwiftApp
//
//  Created by Halin Lee on 6/26/17.
//  Copyright © 2017 Halin. All rights reserved.
//

import Foundation
import UIKit
import Fundamental
import MaterialComponents


class TrackMainViewController: UIViewController,ConfigurableViewController,DesignableViewController {
    
    var viewHolder:TrackMainViewHolder!
    
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        viewHolder = TrackMainViewHolder(parent:self.view)
    }
    
    func viewControllerPresentType() -> ViewControllerPresentType{
        return ViewControllerPresentType.push
    }
    
    func isHideNavigationBar() -> Bool {
        return true
    }
    
    func receiveStartParam(parameters:Dictionary<String, Any>){}
    
    func popWithParam(parameters:Dictionary<String, Any>){}
    
    
    
}
