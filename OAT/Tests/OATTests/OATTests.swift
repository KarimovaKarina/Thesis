import XCTest
@testable import OAT

final class OATTests: XCTestCase {
    var listOfErrors: [AccessibilityLabelError] = { AccessibilityLabelError.allCases }()
    
    func testAll() throws {
         listOfErrors.forEach { error in
            switch error {
            case .labelIsMissing:
                testLabelIsMissing()
                
            case .labelIsEmpty:
                testLabelIsEmpty()
                
            case .endsWithPeriod:
                testLabelEndsWithPeriod()
                
            case .containsType:
                testLabelContainsType()
                
            case .firstWordIsNotCapitalized:
                testLabelFirstWordIsNotCapitalized()
            }
        }
        
        testLabelIsAccessible()
        testCurrentTitleIsAccessible()
        testTitleLabelIsAccessible()
    }
}

//MARK: - Negative

extension OATTests {
    func testLabelIsMissing() {
        let button = UIButton()
        let result = button.isAccessible()

        XCTAssertFalse(result)
    }

    func testLabelIsEmpty() {
        let button = UIButton()
        button.accessibilityLabel = ""
        
        let result = button.isAccessible()

        XCTAssertFalse(result)
    }
    
    func testLabelEndsWithPeriod() {
        
        let button = UIButton()
        button.accessibilityLabel = "Name."
        
        let result = button.isAccessible()
        
        XCTAssertFalse(result)
    }
    
    func testLabelContainsType() {
        let button = UIButton()
        button.accessibilityLabel = "button"
        
        let result = button.isAccessible()
        
        XCTAssertFalse(result)
    }
    
    func testLabelFirstWordIsNotCapitalized() {
        let button = UIButton()
        button.accessibilityLabel = "Button"
        
        let result = button.isAccessible()
        
        XCTAssertFalse(result)
    }
}

//MARK: - Positive

extension OATTests {
    func testLabelIsAccessible() {
        let button = UIButton()
        button.accessibilityLabel = "Log in"
        
        let result = button.isAccessible()
        
        XCTAssertTrue(result)
    }
    
    func testCurrentTitleIsAccessible() {
        let button = UIButton()
        button.setTitle("Log in", for: .normal)
        
        let result = button.isAccessible()
        
        XCTAssertTrue(result)
    }
    
    func testTitleLabelIsAccessible() {
        let button = UIButton()
        button.titleLabel?.text = "Log in"
        
        let result = button.isAccessible()
        
        XCTAssertTrue(result)
    }
}
