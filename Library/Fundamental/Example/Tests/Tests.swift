// https://github.com/Quick/Quick

import Quick
import Nimble
import Fundamental





class TableOfContentsSpec: QuickSpec {
    override func spec() {
        describe("these will fail") {
            
            context("Test Logger"){
                
                it("Execute"){
                    let logUtil = LogUtilDebug();
                    Logger.setup(logUtil:logUtil,isDebug:true)

                    let isDebug = Logger.isDebug()

                    Logger.log(tag:"TAG",message:"Log Test")
                    expect(isDebug) == true
                    
                
                    print(NSStringFromClass(TableOfContentsSpec.self))
                    let loader = ModuleLoader.instance;
                    let bundle = Bundle(for:TableOfContentsSpec.self)
                    loader.loadMudule(bundle:bundle , name:"DemoConfig")
                    
                    let type = DemoConfiguration.self
                    let typeName = NSStringFromClass(type)
                    let config = loader.moduleDictionary[typeName] as! DemoConfiguration
                    let param = config.demoField
                        
                    print("Result:\(param)")
                    expect(config.demoField) == "DemoValue"
                }
            }
            
            context("these will pass") {
                
                it("can do maths") {
                    expect(23) == 23
                }
                
                it("can read") {
                    expect("🐮") == "🐮"
                }
                
                it("will eventually pass") {
                    var time = "passing"
                    
                    DispatchQueue.main.async {
                        time = "done"
                    }
                    
                    waitUntil { done in
                        Thread.sleep(forTimeInterval: 0.5)
                        expect(time) == "done"
                        
                        done()
                    }
                }
            }
        }
    }
}
