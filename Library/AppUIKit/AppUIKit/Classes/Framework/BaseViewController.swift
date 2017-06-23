//
//  BaseViewController.swift
//  Pods
//
//  Created by Halin Lee on 6/23/17.
//
//

import Foundation


/// MVVM Controller
open class BaseViewController<VM:BaseViewModel>: UIViewController {
    
    open var viewModel:VM!;
 
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = createViewModel()
    }
    
    
    /// 构造该页面的ViewModel
    ///
    /// - Returns: 该页面相关ViewModel
    open func createViewModel() -> VM{
        return BaseViewModel() as! VM;
    }
 
}
