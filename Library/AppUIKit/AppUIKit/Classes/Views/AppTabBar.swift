//
//  AppTabBar.swift
//  Pods
//
//  Created by Halin Lee on 6/26/17.
//
//

import Foundation


open class AppTabBar:UIView{
    private var _titles: Array<String> = []
    var titles:Array<String>{
        get{
            return _titles
        }
        set{
            _titles = titles
        }
    }

    let line:UIView

    
    public override init(frame:CGRect) {
        line = UIView(frame:frame)
        super.init(frame:frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    


}
