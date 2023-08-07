import XCTest
import GTXiLib
import UIKit
@testable import FinanceFuelSources

final class FinanceFuelTests: XCTestCase {
    override class func setUp() {
        super.setUp()
        let checksToBeInstalled: [GTXChecking] = GTXChecksCollection.allGTXChecks()
        let tmp = GTXTestSuite.init(allTestsIn: FinanceFuelTests.self)
        GTXiLib.install(on: tmp ?? GTXTestSuite(), checks: checksToBeInstalled, elementExcludeLists: [])
    }

    func testExample() throws {
        let button = AccessibleButton(title: "Color.", color: .black, titleColor: .black)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 40)
        button.accessibilityLabel = "adjustable"
        button.accessibilityHint = "Button opens link"
        button.accessibilityTraits.insert(.link)

        let allScenes = UIApplication.shared.connectedScenes
        let scene = allScenes.first { $0.activationState == .foregroundActive }
                                
        if let windowScene = scene as? UIWindowScene {
                 windowScene.keyWindow?.addSubview(button)
        }
    }
}
