//
//  GlobalConfiguration.swift
//  Pods
//
//  Created by Halin Lee on 5/21/17.
//
//

import Foundation

public class GlobalConfiguration: ConfigurableModule {
    
    static let configurationFileName = "SystemConfiguration"
    static let defaultAppGroup = "group.me.halin";
    static let defaultResourcePath = "resource";
    static let TAG = String(describing:type(of: GlobalConfiguration.self));
    var appGroupId = defaultAppGroup
    var appFilePath = defaultResourcePath
    public required init() {
        super.init()
        appGroupId = self.defaultAppGroupID()
        appFilePath = self.defaultFilePath()
    }
    
    func defaultAppGroupID() -> String {
        
        
        //获得archived-expanded-entitlements.xcent文件
        let bundlePath = Bundle.main.bundlePath;
        let path = "\(bundlePath)/archived-expanded-entitlements.xcent";
        
        //提取文件参数
        let dict = NSDictionary(contentsOfFile:path);
    
        if dict != nil {
            //获得id
            let ids:NSArray = dict?.object(forKey:"com.apple.security.application-groups") as! NSArray;
            let groupsID:String! = ids.firstObject as! String;
            if groupsID != nil {
                //id存在,返回
                return groupsID
            }
        }
        
        return GlobalConfiguration.defaultResourcePath
    }
    
    
    func defaultFilePath() -> String {
        let fileManager = FileManager.default;
        //从plist获得appGroups 并转换为文件路径
        let fileManagerURL = fileManager.containerURL(forSecurityApplicationGroupIdentifier: self.appGroupId);
        
        if fileManagerURL != nil{
            return (fileManagerURL?.path)!;
        } else {
            Logger.log(tag:GlobalConfiguration.TAG ,message: "无法获得App路径 appGroups:\(self.appGroupId) fileManagerURLPath:\(fileManagerURL?.path)")
            let documents = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,FileManager.SearchPathDomainMask.userDomainMask, true)
            return documents.first!;
        }
        
    }
}
