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


class MainViewController: BaseViewController<MainViewModel> ,ConfigurableViewController,DesignableViewController,UITableViewDelegate,UITableViewDataSource{
    
    
    static let ReuseId = "ReuseId"
    
    var navigationBar:UIView!
    var table:UITableView!
    
    
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
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: MainViewController.ReuseId)
    }
    
    open override func createViewModel() -> MainViewModel{
        return MainViewModel()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.viewModel.testCaseArray[section].first?.testGroup;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainViewController.ReuseId)!
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
        _ = Mediator.instance.present(viewControllerClass:testClass , param: nil, animated: true)
        
    }
   
}




