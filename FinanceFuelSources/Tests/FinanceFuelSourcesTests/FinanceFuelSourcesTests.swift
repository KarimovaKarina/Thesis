import XCTest
@testable import FinanceFuelSources
import OAT

final class FinanceFuelSourcesTests: XCTestCase {
    func testExample() throws {        
        let button = AccessibleButton(title: "Ok", hint: "Saves your edits.", color: .mainColor, titleColor: .blue)
        checkAccessibility(button)
    }
    
    func testImageView() throws {
        let image = UIImageView()
        image.isAccessibilityElement = true
        image.accessibilityLabel = "App icon."
        checkAccessibility(image, exclude: .images)
    }
    
    func testTextField() throws {
        let image = UITextView()
        image.textContentType = .telephoneNumber
        checkAccessibility(image, exclude: .images)
    }
}
