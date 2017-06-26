//
//  MediatorView.swift
//  SwiftApp
//
//  Created by Halin Lee on 6/23/17.
//  Copyright © 2017 Halin. All rights reserved.
//

import Foundation
import UIKit
import AppUIKit
import SnapKit


/// 负责创建并管理view
class MediatorViewHolder : ViewHolder{
    
    unowned let mediatorPushButton:UIButton
    unowned let mediatorPresentButton:UIButton
    unowned let mediatorPopButton:UIButton
    unowned let mediatorPopToPushButton:UIButton
    unowned let mediatorPopToPresentButton:UIButton
    unowned let mediatorPopToRoot:UIButton
    
    unowned let pushSheetButton:UIButton
    unowned let presentSheetButton:UIButton
    unowned let popButton:UIButton
    unowned let dismissButton:UIButton
    
    required init(parent:UIView) {
        mediatorPushButton = UIButton(parent:parent)
        mediatorPresentButton = UIButton(parent:parent)
        mediatorPopButton = UIButton(parent:parent)
        mediatorPopToPushButton = UIButton(parent:parent)
        mediatorPopToPresentButton = UIButton(parent:parent)
        mediatorPopToRoot = UIButton(parent:parent)
        
        pushSheetButton = UIButton(parent:parent)
        presentSheetButton = UIButton(parent:parent)
        popButton = UIButton(parent:parent)
        dismissButton = UIButton(parent:parent)
        
        super.init(parent: parent)
        
        parent.addSubview(mediatorPushButton)
        parent.addSubview(mediatorPresentButton)
        parent.addSubview(mediatorPopButton)
        parent.addSubview(mediatorPopToPushButton)
        parent.addSubview(mediatorPopToPresentButton)
        parent.addSubview(mediatorPopToRoot)
        
        parent.addSubview(pushSheetButton)
        parent.addSubview(presentSheetButton)
        parent.addSubview(popButton)
        parent.addSubview(dismissButton)
        
        mediatorPushButton.snp.makeConstraints { (make) in
            make.width.centerX.equalTo(parent)
            make.top.equalTo(parent).offset(AppDimen.HEIGHT_64)
        }
        mediatorPresentButton.snp.makeConstraints { (make) in
            make.width.centerX.equalTo(parent)
            make.top.equalTo(mediatorPushButton.snp.bottom)
        }
        mediatorPopButton.snp.makeConstraints { (make) in
            make.width.centerX.equalTo(parent)
            make.top.equalTo(mediatorPresentButton.snp.bottom)
        }
        mediatorPopToPushButton.snp.makeConstraints { (make) in
            make.width.centerX.equalTo(parent)
            make.top.equalTo(mediatorPopButton.snp.bottom)
        }
        mediatorPopToPresentButton.snp.makeConstraints { (make) in
            make.width.centerX.equalTo(parent)
            make.top.equalTo(mediatorPopToPushButton.snp.bottom)
        }

        mediatorPopToRoot.snp.makeConstraints { (make) in
            make.width.centerX.equalTo(parent)
            make.top.equalTo(mediatorPopToPresentButton.snp.bottom)
        }
        
        pushSheetButton.snp.makeConstraints { (make) in
            make.width.centerX.equalTo(parent)
            make.top.equalTo(mediatorPopToRoot.snp.bottom)
        }
        
        presentSheetButton.snp.makeConstraints { (make) in
            make.width.centerX.equalTo(parent)
            make.top.equalTo(pushSheetButton.snp.bottom)
        }
        popButton.snp.makeConstraints { (make) in
            make.width.centerX.equalTo(parent)
            make.top.equalTo(presentSheetButton.snp.bottom)
        }
        dismissButton.snp.makeConstraints { (make) in
            make.width.centerX.equalTo(parent)
            make.top.equalTo(popButton.snp.bottom)
        }
        
        setTitle(string: "Mediator Push", button: mediatorPushButton)
        setTitle(string: "Mediator Present", button: mediatorPresentButton)
        setTitle(string: "Mediator Pop", button: mediatorPopButton)
        setTitle(string: "Mediator Pop To Push", button: mediatorPopToPushButton)
        setTitle(string: "Mediator Pop To Present", button: mediatorPopToPresentButton)
        setTitle(string: "Mediator Pop To Root", button: mediatorPopToRoot)
        setTitle(string: "Push Sheet", button: pushSheetButton)
        setTitle(string: "Present Sheet", button: presentSheetButton)
        setTitle(string: "Pop", button: popButton)
        setTitle(string: "Dismiss", button: dismissButton)
        
    
    }
    
    func setTitle(string:String,button:UIButton){
        button.setAttributedTitle(string.attributeString(), for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
