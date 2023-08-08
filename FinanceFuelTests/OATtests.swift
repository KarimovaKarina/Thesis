import XCTest
import OAT
@testable import FinanceFuelSources

final class OATFinanceFuelTests: XCTestCase {
    func testExample() throws {
        let button = AccessibleButton(title: "Button link.", color: .black, titleColor: .black)
        button.accessibilityTraits.insert(.link)
        button.accessibilityHint = "Button opens link."
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 40)
        checkAccessibility(button)
    }
    
    func testDuplicates() throws {
        let view = WelcomeView(logInButtonTitle: "log in1", registerButtonTitle: "log in")
        checkAccessibility(
            view,
            with: .init(excluding: [.images], recursiveChecking: true)
        )
    }
}
