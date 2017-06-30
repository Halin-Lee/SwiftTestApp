//
//  ScrollDirectHandler.swift
//  Pods
//
//  Created by Halin Lee on 6/27/17.
//
//

import Foundation
import SnapKit
import ReactiveCocoa
import ReactiveSwift
import Result



public extension UIScrollView{

    public func scrollDirectHandler() -> Signal<Bool, NoError> {
        return ScrollViewScrollDirectHandler(scroll:self).scrollUp.signal
    }
}


fileprivate class ScrollViewScrollDirectHandler{
    let scrollUp = MutableProperty<Bool>(false)
    
    static let threshold:CGFloat = 73.0;
    var lastContentOffset:CGFloat = 0.0
    let scroll:UIScrollView
    
    init(scroll:UIScrollView) {
        self.scroll = scroll
        bindAnimation()
    }
    func bindAnimation(){
        
        scroll.reactive.producer(forKeyPath: #keyPath(UIScrollView.contentOffset))
            .startWithValues { value in
                self.handleDraging(currentOffset: (value as! CGPoint).y)
        }
        
        scroll.reactive.trigger(for: #selector(UIView.touchesBegan(_:with:))).observe{
            _ in
            self.lastContentOffset = 0
        }
        
        
    }
    
    
    
    func handleDraging(currentOffset:CGFloat){
        
        if !scroll.isTracking && !scroll.isDragging && !scroll.isDecelerating {
            //用户没有点击，清空上次滑动位置，不处理
            lastContentOffset = 0
            print("不处理")
            return
        }
        
        //上拉超过阀值隐藏导航栏
        if(currentOffset > self.lastContentOffset){
            if(currentOffset >= ScrollViewScrollDirectHandler.threshold){
                self.scrollUp.value = false
            }
        }
        
        //下拉立马显示
        if(currentOffset < self.lastContentOffset){
            if(currentOffset > 0){
                self.scrollUp.value = true
            } else{
                //显示
                self.scrollUp.value = true
            }
        }
        
        self.lastContentOffset = currentOffset;
    }
}

