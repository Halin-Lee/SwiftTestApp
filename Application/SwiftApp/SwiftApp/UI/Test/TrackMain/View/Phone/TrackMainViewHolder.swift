//
//  TrackMainViewHolder.swift
//  SwiftApp
//
//  Created by Halin Lee on 6/26/17.
//  Copyright © 2017 Halin. All rights reserved.
//

import Foundation
import AppUIKit
import SnapKit
import ReactiveCocoa
import ReactiveSwift
import MaterialComponents

class TrackMainViewHolder: ViewHolder{

    unowned let navigation:MDCNavigationBar
    unowned let table:UITableView
    unowned let tab:MDCTabBar
    unowned let floatingButton:MDCFloatingButton
    
    let dataSource:TrackMainDataSource
    
    required init(parent:UIView) {
        navigation = MDCNavigationBar(parent:parent)
        table = UITableView(parent:parent)
        tab = MDCTabBar(parent:parent)
        floatingButton = MDCFloatingButton(parent:parent)
        
        
        dataSource = TrackMainDataSource(table:table)
        super.init(parent: parent)
        
        navigation.snp.makeConstraints { (make) in
            make.centerX.top.equalTo(parent)
            make.width.equalTo(AppDimen.SCREEN_WIDTH)
            make.height.equalTo(AppDimen.HEIGHT_64)
        }
        tab.snp.makeConstraints { (make) in
            make.centerX.width.equalTo(parent)
            make.top.equalTo(navigation.snp.bottom)
            make.height.equalTo(AppDimen.HEIGHT_44)
        }
        
        table.snp.makeConstraints { (make) in
            make.centerX.width.bottom.equalTo(parent)
            make.top.equalTo(navigation.snp.bottom)
            
        }
        
        floatingButton.snp.makeConstraints { (make) in
            make.right.bottom.equalTo(parent).offset(-AppDimen.MARGIN_8)
            make.size.equalTo(AppDimen.SIZE_56)
        }
        
        
        parent.bringSubview(toFront: navigation)
        navigation.backgroundColor = AppColor.Color_Blue
        navigation.leadingBarButtonItem = UIBarButtonItem(title:"17TRACK",style:.plain,target:nil,action:nil)
        navigation.tintColor = UIColor.white
        
        table.contentInset = UIEdgeInsetsMake(AppDimen.HEIGHT_44, 0, 0, 0)
        table.scrollToRow(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
        table.scrollDirectHandler().observeValues{[weak self] value in
            self!.updateViewWhenScroll(scollUp: value)
        }
        

        
        tab.backgroundColor = AppColor.Color_Blue
    
        tab.items = [UITabBarItem(title:"Hello",image:nil,tag:0),UITabBarItem(title:"World",image:nil,tag:1)]
        tab.selectedItemTintColor = UIColor.white
        tab.tintColor = UIColor.white
        tab.alignment = .justified
        
        MDCSnackbarManager.show(MDCSnackbarMessage(text:"Hello World"))
    }
    
    func updateViewWhenScroll(scollUp:Bool){
        self.tab.snp.updateConstraints{(make) in
            if(scollUp){
                make.top.equalTo(self.navigation.snp.bottom)
            } else {
                make.top.equalTo(self.navigation.snp.bottom).offset( -AppDimen.HEIGHT_40)
            }
        }
        //设置tabbar
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            self.parent.layoutIfNeeded()
        }, completion: nil)
    }

}
