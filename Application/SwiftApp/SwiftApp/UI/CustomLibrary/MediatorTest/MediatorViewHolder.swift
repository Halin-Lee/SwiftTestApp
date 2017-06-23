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
class MediatorViewHolder {
    
    let pushButton:UIButton
    let presentButton:UIButton
    let popButton:UIButton
    let popToPushButton:UIButton
    let popToPresentButton:UIButton
    let popToRoot:UIButton
    let dismiss:UIButton
    
    init(parent:UIView) {
        pushButton = UIButton()
        presentButton = UIButton()
        popButton = UIButton()
        popToPushButton = UIButton()
        popToPresentButton = UIButton()
        popToRoot = UIButton()
        dismiss = UIButton()
        
        parent.addSubview(pushButton)
        parent.addSubview(presentButton)
        parent.addSubview(popButton)
        parent.addSubview(popToPushButton)
        parent.addSubview(popToPresentButton)
        parent.addSubview(popToRoot)
        parent.addSubview(dismiss)
        
        pushButton.snp.makeConstraints { (make) in
            make.width.centerX.equalTo(parent)
            make.top.equalTo(parent).offset(AppDimen.HEIGHT_64)
        }
        presentButton.snp.makeConstraints { (make) in
            make.width.centerX.equalTo(parent)
            make.top.equalTo(pushButton.snp.bottom)
        }
        popButton.snp.makeConstraints { (make) in
            make.width.centerX.equalTo(parent)
            make.top.equalTo(presentButton.snp.bottom)
        }
        popToPushButton.snp.makeConstraints { (make) in
            make.width.centerX.equalTo(parent)
            make.top.equalTo(popButton.snp.bottom)
        }
        popToPresentButton.snp.makeConstraints { (make) in
            make.width.centerX.equalTo(parent)
            make.top.equalTo(popToPushButton.snp.bottom)
        }

        popToRoot.snp.makeConstraints { (make) in
            make.width.centerX.equalTo(parent)
            make.top.equalTo(popToPresentButton.snp.bottom)
        }
        
        dismiss.snp.makeConstraints { (make) in
            make.width.centerX.equalTo(parent)
            make.top.equalTo(popToRoot.snp.bottom)
        }
        
        
        pushButton.setAttributedTitle("Push".attributeString(), for: .normal)
        presentButton.setAttributedTitle("Present".attributeString(), for: .normal)
        popButton.setAttributedTitle("popButton".attributeString(), for: .normal)
        popToPushButton.setAttributedTitle("popToPushButton".attributeString(), for: .normal)
        popToPresentButton.setAttributedTitle("popToPresentButton".attributeString(), for: .normal)
        popToRoot.setAttributedTitle("popToRoot".attributeString(), for: .normal)
        dismiss.setAttributedTitle("dismiss".attributeString(), for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
