//
//  LogUtilGoogle.swift
//  SwiftApp
//
//  Created by Halin Lee on 6/30/17.
//  Copyright © 2017 Halin. All rights reserved.
//
import Foundation
import Fundamental
//import ObjectiveC

public class LogUtilGoogle:LogUtil{
    
    let gaiInstance:GAI
    let tracker:GAITracker
    let uuid:String
    public init(id:String) {
        gaiInstance = GAI.sharedInstance()
        gaiInstance.trackUncaughtExceptions = true
        gaiInstance.dispatchInterval = 20
        gaiInstance.logger.logLevel = GAILogLevel.error
        gaiInstance.tracker(withTrackingId: id)
        tracker = gaiInstance.defaultTracker
        
        uuid = (UIDevice.current.identifierForVendor?.uuidString)!
        
    }
    
    public func log(message:String){
        //谷歌分析不打印普通级别日志
    }
    
    public func logE(message:String){
        let logStr = "\(uuid) | \(message)"
        let dict = GAIDictionaryBuilder.createException(withDescription: logStr, withFatal: 1).build()
        tracker.send(dict as! [AnyHashable : Any])
    }
}
