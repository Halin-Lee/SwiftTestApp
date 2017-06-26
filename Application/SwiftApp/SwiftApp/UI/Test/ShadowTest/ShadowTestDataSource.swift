//
//  ShadowTestViewController+DataSource.swift
//  SwiftApp
//
//  Created by Halin Lee on 6/26/17.
//  Copyright © 2017 Halin. All rights reserved.
//

import Foundation
import AppUIKit
import SnapKit

class ShadowTestDataSource:NSObject,UITableViewDelegate,UITableViewDataSource{
    
    static let reuseId = "ReuseId"
    let items:Array<String>
    

    init(table:UITableView) {
        items = ["View","Label","Button","Cell"]
        
        super.init()
        table.delegate = self
        table.dataSource = self

    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let view = viewForTitle(title:items[indexPath.section])
        cell.contentView.addSubview(view)
        
        
        view.snp.makeConstraints { (make) in
            make.top.left.equalTo(cell.contentView).offset(AppDimen.MARGIN_8)
            make.bottom.right.equalTo(cell.contentView).offset(-AppDimen.MARGIN_8)
        }
        let layer = view.layer
        layer.cornerRadius = 4.0
        layer.shadowColor = UIColor(red:0,green:0,blue:0,alpha:0.12).cgColor //Shadow的透明度貌似无影响
        layer.shadowOffset = CGSize(width:0,height:0)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 1.0
        view.backgroundColor = UIColor.white
        
        return cell
    }
    
    func viewForTitle(title:String) -> UIView {
        switch title {
        case "View":
            return UIView()
        case "Label":
            return UILabel()
        case "Button":
            return UIButton()
        default:
            return UIView()
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return AppDimen.HEIGHT_40
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return items[section]
    }
    
}
