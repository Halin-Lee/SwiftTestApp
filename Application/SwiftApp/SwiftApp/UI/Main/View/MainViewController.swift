//
//  MainViewController.swift
//  SwiftApp
//
//  Created by Halin Lee on 6/23/17.
//  Copyright © 2017 Halin. All rights reserved.
//

import Foundation
import Fundamental
import AppUIKit


class MainViewController: BaseViewController<MainViewModel> ,ConfigurableViewController,DesignableViewController{
    
    
    var navigationBar:UIView!
    var table:UITableView!
    var dataSource:MainViewDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createView()
    }
    
    func createView() {
        let view = self.view!
        
        //初始化Navigation
        view.backgroundColor = UIColor.white
        navigationBar = AppNavigation(parent:view)
        
        //初始化Table
        table = UITableView()
        view.addSubview(table)
        table.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(view)
            make.top.equalTo(navigationBar.snp.bottom)
        }
        dataSource = MainViewDataSource(controller:self,viewModel:viewModel, table: table)
        
        
    }
    
    open override func createViewModel() -> MainViewModel{
        return MainViewModel()
    }
 
}




