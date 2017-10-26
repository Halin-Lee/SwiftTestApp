//
//  ReactiveSwfitTest.swift
//  SwiftApp
//
//  Created by Halin Lee on 8/26/17.
//  Copyright © 2017 Halin. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

class ReactiveSwiftTest {
    
    static let (itemReloadSignal,itemReloadObserver) = Signal<String,NoError>.pipe()
    
    static let (allReloadSignal,allReloadObserver) = Signal<(),NoError>.pipe()
    
    class func start() {
        itemReloadSignal.throttle( 0.0, on: QueueScheduler.main).take(until: allReloadSignal).observeValues { (string) in
            print("收到信号 \(string)")
        }
        
//        
//        timer(interval: .seconds(2), on: QueueScheduler.main).startWithSignal { (signal, disposable) in
//            signal.observeValues({ (_) in
//                print("发送信号 Test1")
//                itemReloadObserver.send(value: "Test1")
//            })
//        }
        timer(interval: .seconds(3), on: QueueScheduler.main).startWithSignal { (_, _) in
            print("发送信号 Test2")
            itemReloadObserver.send(value: "Test2")
            DispatchQueue.main.async {
                print("async 执行")
            }
        }

        
        print("测试初始化结束")
    }
}
