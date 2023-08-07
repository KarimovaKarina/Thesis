import XCTest
import GTXiLib
import UIKit
@testable import FinanceFuelSources

final class FinanceFuelTests: XCTestCase {
    let button = UIButton()

    override class func setUp() {
        super.setUp()
        let checksToBeInstalled: [GTXChecking] = GTXChecksCollection.allGTXChecks()
        let tmp = GTXTestSuite.init(allTestsIn: FinanceFuelTests.self)
        GTXiLib.install(on: tmp ?? GTXTestSuite(), checks: checksToBeInstalled, elementExcludeLists: [])
    }

    func testExample() throws {
        button.setTitle("button.", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setBackgroundColor(.black, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        
        let allScenes = UIApplication.shared.connectedScenes
        let scene = allScenes.first { $0.activationState == .foregroundActive }
                                
        if let windowScene = scene as? UIWindowScene {
                 windowScene.keyWindow?.addSubview(button)
        }
    }
    
    override func tearDown() {
        super.tearDown()
      
    }
}
