//
//  MediatorSheetViewController.swift
//  SwiftApp
//
//  Created by Halin Lee on 6/25/17.
//  Copyright © 2017 Halin. All rights reserved.
//

import Foundation
import AppUIKit
import Fundamental
import UIKit

class MediatorSheetViewController : UIViewController{
    
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.preferredContentSize = CGSize(width:AppDimen.SCREEN_WIDTH/2 ,height:AppDimen.SCREEN_HEIGHT/2)
        self.modalPresentationStyle = .overCurrentContext
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.gray
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true, completion: nil)
    }

}
