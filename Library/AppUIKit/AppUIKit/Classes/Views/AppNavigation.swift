//
//  AppNavigation.swift
//  Pods
//
//  Created by Halin Lee on 6/23/17.
//
//

import Foundation
import SnapKit


/// 自定义的导航栏
open class AppNavigation: UIView {
    
    public convenience init(parent:UIView) {
        self.init()
        parent.addSubview(self)
        self.snp.makeConstraints { (make) in
            make.centerX.top.equalTo(parent)
            make.width.equalTo(AppDimen.SCREEN_WIDTH)
            make.height.equalTo(AppDimen.HEIGHT_64)
        }
        parent.bringSubview(toFront: self)
    }
    
    required public init() {
        super.init(frame:CGRect())
        self.backgroundColor = AppColor.Color_Blue
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
   
}
