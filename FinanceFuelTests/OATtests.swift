import XCTest
import OAT
@testable import FinanceFuelSources

final class OATFinanceFuelTests: XCTestCase {
    func testWelcomeView() throws {
        let view = WelcomeView(
            logInButtonTitle: "Log in",
            registerButtonTitle: "Log in"
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
}
