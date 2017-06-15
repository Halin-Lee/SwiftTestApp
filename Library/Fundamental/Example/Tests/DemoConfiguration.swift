//
//  DemoConfiguration.swift
//  Fundamental
//
//  Created by Halin Lee on 5/21/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import Fundamental

class DemoConfiguration :ConfigurableModule{
   
    public var demoField:String = "Null"
    
    public required init() {
        super.init()
    }
}
