//
//  MainViewController+DataSource.swift
//  SwiftApp
//
//  Created by Halin Lee on 6/23/17.
//  Copyright © 2017 Halin. All rights reserved.
//

import Foundation
import AppUIKit
import Fundamental


class MainViewDataSource:NSObject,UITableViewDelegate,UITableViewDataSource{
    
    
    static let reuseId = "ReuseId"
    unowned let  viewModel:MainViewModel
    unowned let controller:UIViewController
    
    init(controller:UIViewController,viewModel:MainViewModel,table:UITableView) {
        self.viewModel = viewModel
        self.controller = controller
        super.init()
        table.dataSource = self
        table.delegate = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: MainViewDataSource.reuseId)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.viewModel.testCaseArray[section].first?.testGroup;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainViewDataSource.reuseId)!
        cell.textLabel?.text = self.viewModel.testCaseArray[indexPath.section][indexPath.row].testName
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return AppDimen.HEIGHT_40
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.testCaseArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.testCaseArray[section].count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let testClass = self.viewModel.testCaseArray[indexPath.section][indexPath.row].testClass
        _ = Mediator.instance.present(controllerClass: testClass, currentVC: controller)
        
    }

}
