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
    
    func testLoginView() throws {
        let view = LoginView(buttonTitle: "Register.")
        let scene = UIApplication.shared.connectedScenes
            .first { $0.activationState == .foregroundActive }

        if let windowScene = scene as? UIWindowScene {
            windowScene.keyWindow?.addSubview(view)
        }
    }
    
    func testCustomView() throws {
        let view = UIView()
        view.backgroundColor = .brown
        view.frame = .init(origin: .zero, size: .init(width: 300, height: 500))

        let button = UIButton(frame: CGRect(x: 123, y: 123, width: 20, height: 10))
        button.setTitle("Register.", for: .normal)

        let image = UIImageView(frame: CGRect(x: 123, y: 173, width: 50, height: 50))
        image.image = UIImage(named: "heart.fill")

        image.isAccessibilityElement = true
        image.accessibilityLabel = "App icon"

        view.addSubview(button)
        view.addSubview(image)

        let scene = UIApplication.shared.connectedScenes
            .first { $0.activationState == .foregroundActive }

        if let windowScene = scene as? UIWindowScene {
            windowScene.keyWindow?.addSubview(view)
        }
    }
}
