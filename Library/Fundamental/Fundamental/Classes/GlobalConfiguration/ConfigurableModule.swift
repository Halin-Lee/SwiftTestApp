//
//  ConfigurableProtocol.swift
//  Pods
//
//  Created by Halin Lee on 5/20/17.
//
//

import Foundation


/// 可配置化的类协议，只有继承该协议，才能在初始化时被自动调用
open class ConfigurableModule : NSObject{
    public required override init() {
        
    }
}
