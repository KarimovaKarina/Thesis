import XCTest
import OAT
@testable import FinanceFuelSources

final class OATFinanceFuelTests: XCTestCase {
    func testWelcomeView() throws {
        let view = WelcomeView(
            logInButtonTitle: "Log in",
            registerButtonTitle: "Register"
        )
        checkAccessibility(
            view,
            with: .init(excluding: [.images], recursiveChecking: true)
        )
    }
    
    func testLoginView() throws {
        let view = LoginView(buttonTitle: "Log in")
        checkAccessibility(
            view,
            with: .init(excluding: [.images], recursiveChecking: true)
        )
    }
    
    func testTargetSize() {
        let button = UIButton()
        button.frame = CGRect(origin: .zero, size: .init(width: 30, height: 30))
        checkAccessibility(button)
    }
}
