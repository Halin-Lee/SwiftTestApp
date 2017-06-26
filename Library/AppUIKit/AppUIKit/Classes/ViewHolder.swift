//
//  ViewHolder.swift
//  Pods
//
//  Created by Halin Lee on 6/26/17.
//
//

import Foundation

open class ViewHolder{

    open unowned let parent:UIView
    public required init(parent:UIView) {
        self.parent = parent
    }
    
}
