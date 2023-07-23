import XCTest
@testable import FinanceFuelSources
import OAT

final class FinanceFuelSourcesTests: XCTestCase {
    func testExample() throws {
        let button = AccessibleButton(title: "Ok", color: .mainColor, titleColor: .blue)
        checkAccessibility(button)
    }
}
