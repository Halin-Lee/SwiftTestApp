//
//  LogUtilDebug.swift
//  Pods
//
//  Created by Halin Lee on 5/20/17.
//
//

import Foundation

public class LogUtilDebug:LogUtil{

    public init() {
        
    }
    
    public func log(message:String){
        print(message);
    }
    
    public func logE(message:String){
        print(message)
    }
}
