// https://github.com/Quick/Quick

import Quick
import Nimble
import Fundamental



class Sample{
    func test() {
        print("method called")
    }
}

class ModuleLoaderSpec: QuickSpec {
    override func spec() {
        describe("") {
            
            context("Test Logger"){
                
                it("Execute"){
                    
                    let logUtil = LogUtilDebug();
                    Logger.setup(logUtil:logUtil,isDebug:true)
                    let isDebug = Logger.isDebug()
                    Logger.log(tag:"TAG",message:"Log Test")
                    expect(isDebug) == true
                    
                    
                    print(NSStringFromClass(ModuleLoaderSpec.self))
                    let loader = ModuleLoader.instance;
                    let bundle = Bundle(for:ModuleLoaderSpec.self)
                    loader.loadMudule(bundle:bundle , name:"DemoConfig")
                    
                    let type = DemoConfiguration.self
                    let typeName = NSStringFromClass(type)
                    let config = loader.moduleDictionary[typeName] as! DemoConfiguration
                    let param = config.demoField
                    
                    print("Result:\(param)")
                    expect(config.demoField) == "DemoValue"
                }
            }
            
        }
    }
}
