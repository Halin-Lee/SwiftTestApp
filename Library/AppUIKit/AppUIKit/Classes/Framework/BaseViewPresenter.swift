//
//  BasePresenter.swift
//  Pods
//
//  Created by Halin Lee on 6/23/17.
//
//

import Foundation


/// MVVM Presenter，负责处理这个页面的业务
open class BaseViewPresenter<VM:BaseViewModel>{
    
    unowned let viewModel:VM
    
    public init(viewModel:VM) {
        self.viewModel = viewModel
    }
}
