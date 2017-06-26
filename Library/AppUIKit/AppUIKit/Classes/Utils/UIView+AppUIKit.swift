//
//  UIView+AppUIKit.swift
//  Pods
//
//  Created by Halin Lee on 6/26/17.
//
//

import Foundation

extension UIView{
    
    public convenience init(parent:UIView) {
        self.init()
        parent.addSubview(self)
        parent.bringSubview(toFront: self)
    }
    


}
