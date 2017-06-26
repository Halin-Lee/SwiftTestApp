//
//  ConfigurableViewController.swift
//  Pods
//
//  Created by Halin Lee on 6/22/17.
//
//

import Foundation

public enum ViewControllerPresentType {
    case PresentTypePresent
    case PresentTypePush
}


/// 可配置启动参数的VC
public protocol ConfigurableViewController {
    
    /// 收到启动参数
    ///
    /// - Parameter parameters: 启动参数
    func receiveStartParam(parameters:Dictionary<String, Any>)
    
    /// 收到返回参数
    ///
    /// - Parameters:
    ///   - parameters: 参数
    ///   - fromRemote: 是否由直系儿子（调用pop）返回
    func receivePopParam(parameters:Dictionary<String, Any>,fromChild:Bool)
}

///默认实现
public extension ConfigurableViewController{
    
    func receiveStartParam(parameters:Dictionary<String, Any>){}

    func receivePopParam(parameters:Dictionary<String, Any>,fromChild:Bool){}
}



/// 可配置动画的VC
public protocol DesignableViewController{
    
    
    /// 展示形式 ，默认为push
    ///
    /// - Returns: <#return value description#>
    func viewControllerPresentType() -> ViewControllerPresentType
    
    
    /// 是否显示Navigation，默认不显示
    ///
    /// - Returns: <#return value description#>
    func isHideNavigationBar() -> Bool
    
    
    /// 页面标签（用于指定回退），默认为空文本
    ///
    /// - Returns: <#return value description#>
    func tag() -> String
}


///默认实现
public extension DesignableViewController{
    func viewControllerPresentType() -> ViewControllerPresentType{
        return .PresentTypePush
    }
    
    
    func isHideNavigationBar() -> Bool{
        return true;
    }
    
    
    func tag() -> String{
        return ""
    }
}

