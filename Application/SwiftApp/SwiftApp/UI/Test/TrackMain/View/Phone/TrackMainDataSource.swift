//
//  TrackMainDataSource.swift
//  SwiftApp
//
//  Created by Halin Lee on 6/26/17.
//  Copyright © 2017 Halin. All rights reserved.
//

import Foundation

import AppUIKit
import SnapKit

class TrackMainDataSource: NSObject,UITableViewDelegate,UITableViewDataSource {
    static let reuseId = "ReuseId"
    
    
    init(table:UITableView) {
        super.init()
        table.delegate = self
        table.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return AppDimen.HEIGHT_40
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1300
    }

}
