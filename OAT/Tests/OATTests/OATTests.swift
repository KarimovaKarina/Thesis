import XCTest
@testable import OAT

final class OATTests: XCTestCase {
    func testExample_negative() throws {
        let checker = UIButtonOAT()
        let button = UIButton()
        let result = checker.test(button)
        
        XCTAssertFalse(result)
    }

    func testExample_positive() throws {
        let checker = UIButtonOAT()
        
        let button = UIButton()
        button.accessibilityLabel = "Asdf"
        
        let result = checker.test(button)
        
        XCTAssertTrue(result)
    }
}
