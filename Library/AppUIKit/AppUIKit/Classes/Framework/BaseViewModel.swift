//
//  BaseViewModel.swift
//  Pods
//
//  Created by Halin Lee on 6/23/17.
//
//

import Foundation


/// 页面ViewModel，存放这个页面涉及的所有业务模型
open class BaseViewModel{

    public init() {
        
    }
    
    
    /// 构造该ViewModel下的所有Presenter
    ///
    /// - Returns:该ViewModel下的所有Presenter
    func createPresents() -> Array<BaseViewPresenter<BaseViewModel>> {
        return [BaseViewPresenter(viewModel: self)]
    }

}
