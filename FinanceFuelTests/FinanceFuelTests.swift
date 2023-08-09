import XCTest
import GTXiLib
import UIKit
@testable import FinanceFuelSources

final class FinanceFuelTests: XCTestCase {
    override class func setUp() {
        super.setUp()
        GTXiLib.install(
            on: GTXTestSuite(allTestsIn: FinanceFuelTests.self),
            checks: GTXChecksCollection.allGTXChecks(),
            elementExcludeLists: []
        )
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testButton() {
        let scene = UIApplication.shared.connectedScenes
            .first { $0.activationState == .foregroundActive }

        if let windowScene = scene as? UIWindowScene {
            windowScene.keyWindow?.addSubview(accessibleButton)
        }
    }
}
