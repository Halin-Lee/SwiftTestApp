//
//  Logger.swift
//  Pods
//
//  Created by Halin Lee on 5/20/17.
//
//

import Foundation


public class Logger {
    
    let logUtil:LogUtil
    
    let debug:Bool

    static var logger:Logger!
    
    static let TAG:String = "Logger"
    
    init(logUtil:LogUtil,isDebug:Bool) {
        self.logUtil = logUtil;
        self.debug = isDebug;
    }
    
    
    /// 初始化日志日志工具
    ///
    /// - Parameters:
    ///   - logUtil: 日志工具
    ///   - isDebug: 是否为调试模式
    public static func setup(logUtil:LogUtil,isDebug:Bool) {
        logger = Logger(logUtil: logUtil,isDebug: isDebug);
        
        let model = isDebug ? "DEBUG" : "RELEASE";
        
        NSSetUncaughtExceptionHandler { (exception) in
            Logger.logE(tag:Logger.TAG,message:"程序崩溃,堆栈:\(exception.callStackSymbols)");
        }
        
        Logger.log(tag:TAG,message:"日志工具初始化完成 模式:\(model)")
    }
    
    
    /// 当前模式
    ///
    /// - Returns: true 调试模式
    public static func isDebug() -> Bool {
        return logger.debug;
    }



    /// 打印普通级别日志
    ///
    /// - Parameters:
    ///   - tag: 标签
    ///   - message: 打印文本
    public static func log(tag:String,message:String){
        
        let logStr = "\(tag) | \(message)";
        
        if (logger != nil) {
            logger.logUtil.log(message:logStr);
        }
    }
    
    /// 打印异常级别日志
    ///
    /// - Parameters:
    ///   - tag: 标签
    ///   - message: 打印文本
    public static func logE(tag:String,message:String){
        
        let logStr = "\(tag) | \(message)";
        
        if (logger != nil) {
            logger.logUtil.logE(message:logStr);
        }
    }
}
