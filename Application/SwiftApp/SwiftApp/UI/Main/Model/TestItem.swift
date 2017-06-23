//
//  TestItem.swift
//  SwiftApp
//
//  Created by Halin Lee on 6/23/17.
//  Copyright © 2017 Halin. All rights reserved.
//

import Foundation
import UIKit

class TestItem {
    let testName:String
    let testGroup:String
    let testClass:UIViewController.Type
    
    convenience init(testName:String,testClass:UIViewController.Type) {
        self.init(testName: testName,testGroup: testName,testClass: testClass)
    }
    
    init(testName:String, testGroup:String, testClass:UIViewController.Type) {
        self.testName = testName
        self.testGroup = testGroup
        self.testClass = testClass
    }
    
}
