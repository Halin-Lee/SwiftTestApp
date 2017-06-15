//
//  ModuleLoader.swift
//  Pods
//
//  Created by Halin Lee on 5/20/17.
//
//

import Foundation
import SWXMLHash
public class ModuleLoader{

    
    public static let instance = ModuleLoader()
    
    public var moduleDictionary = Dictionary<String,ConfigurableModule>();
    
    public required init() {
    }

    public func loadMudule(name:String) {
        self.loadMudule(bundle: Bundle.main, name: name);
    }
    
    public func loadMudule(bundle:Bundle, name:String) {
        let pathURL = bundle.url(forResource: name, withExtension: "xml");

        let data = try? Data(contentsOf:pathURL!)
        let xml = SWXMLHash.lazy(data!);
        
        for elem in xml["SystemConfig"]["ModuleList"]["Module"] {
            let moduleName = elem.element?.attribute(by: "name")?.text;
            if (moduleName != nil) {
                let module = self.createInstance(fromClass: moduleName!);
                self.paserConfig(xml: elem, toModule: module);
                self.moduleDictionary[moduleName!] = module;
            }
        }
    }

    
    func createInstance(fromClass className:String) -> ConfigurableModule {
        
        let cls: AnyObject.Type = NSClassFromString(className)! ;
        let type = cls as! ConfigurableModule.Type ;
        return type.init();
    }
    
    func paserConfig(xml:XMLIndexer, toModule module:ConfigurableModule){
        for elem in xml.children{
            let element = elem.element
            let type = element?.name
            let name = element?.attribute(by: "name")?.text
            
            if type == "string" {
                let value = element?.text;
                module .setValue(value, forKey: name!);
            }
            
        }
    }
}
