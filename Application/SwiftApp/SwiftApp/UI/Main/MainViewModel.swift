//
//  MainViewModel.swift
//  SwiftApp
//
//  Created by Halin Lee on 6/23/17.
//  Copyright © 2017 Halin. All rights reserved.
//

import Foundation
import AppUIKit

class MainViewModel: BaseViewModel {
    
    let testCaseArray:Array<Array<TestItem>>
    
    override init() {
        testCaseArray = [[TestItem(testName:"Hello World",testClass:HelloWorldViewController.self)],
                         [TestItem(testName:"Push",testGroup:"MediatorTest",testClass:MediatorPushViewController.self),
                          TestItem(testName:"Present",testGroup:"MediatorTest",testClass:MediatorPresentViewController.self)],
                         [TestItem(testName:"Shadow Test",testClass:ShadowTestViewController.self)],]
        super.init()
    }
    
    func createPresents() -> Array<BaseViewPresenter<MainViewModel>> {
        return [MainViewPresenter(viewModel: self)]
    }

    
    
}
