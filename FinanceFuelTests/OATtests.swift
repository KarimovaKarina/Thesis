import XCTest
import OAT
@testable import FinanceFuelSources

final class OATFinanceFuelTests: XCTestCase {
    func testExample() throws {
        let button = AccessibleButton(title: "Color.", color: .black, titleColor: .black)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 40)
        checkAccessibility(button)
    }
}
