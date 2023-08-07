import XCTest
import GTXiLib
@testable import FinanceFuelSources

final class FinanceFuelTests: XCTestCase {
    override class func setUp() {
        super.setUp()
//               let checksToBeInstalled: [GTXChecking] = GTXChecksCollection.allGTXChecks()
        let checksToBeInstalled: [GTXChecking] = [GTXChecksCollection.checkForAXLabelNotPunctuated()]
        let tmp = GTXTestSuite.init(allTestsIn: FinanceFuelTests.self)
        GTXiLib.install(on: tmp ?? GTXTestSuite(), checks: checksToBeInstalled, elementExcludeLists: [])
    }

    func testExample() throws {
        let button = UIButton()
        button.setTitle("Ok.", for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        keyWindow?.addSubview(button)
    }
}
