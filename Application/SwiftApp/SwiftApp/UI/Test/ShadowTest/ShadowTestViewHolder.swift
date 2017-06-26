//
//  ShadowTestViewHolder.swift
//  SwiftApp
//
//  Created by Halin Lee on 6/26/17.
//  Copyright © 2017 Halin. All rights reserved.
//

import Foundation
import AppUIKit
import SnapKit

/// 负责创建并管理view
class ShadowTestViewHolder : ViewHolder{
    unowned let table:UITableView
    let dataSource:ShadowTestDataSource
    let navigation:AppNavigation
    
    required init(parent:UIView) {
        
        self.navigation = AppNavigation(parent:parent)
        self.table = UITableView(parent:parent)
        
        dataSource = ShadowTestDataSource(table: table)
        super.init(parent: parent)
 
        parent.addSubview(table)
        
        
        table.snp.makeConstraints { (make) in
            make.centerX.width.bottom.equalTo(parent)
            make.top.equalTo(navigation.snp.bottom).offset(AppDimen.MARGIN_8)
        }
    }
}
