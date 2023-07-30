import XCTest
import UIKit

private let checker = UIButtonOAT()
private let imageViewChecker = UIImageViewOAT()

public extension UIView {
    func check() {
        checkAccessibility(self)
    }
}

public func checkAccessibility(
    _ view: UIView,
    file: StaticString = #file,
    testName: String = #function,
    line: UInt = #line
) {
    if let control = view as? UIControl {
        checkUIControl(control, file: file, testName: testName, line: line)
    } else if let imageView = view as? UIImageView {
        checkUIImageView(imageView, file: file, testName: testName, line: line)
    }
}

func checkUIImageView(
    _ imageView: UIImageView,
    file: StaticString = #file,
    testName: String = #function,
    line: UInt = #line
) {
    imageViewChecker.check(imageView).forEach { error in
        XCTFail(error.errorMessage, file: file, line: line)
    }
}

func checkUIControl(
    _ view: UIControl,
    file: StaticString = #file,
    testName: String = #function,
    line: UInt = #line
) {
    if let button = view as? UIButton {
        checker.check(button).forEach { error in
            XCTFail(error.errorMessage, file: file, line: line)
        }
    }
}

class UIButtonOAT {
    func check(_ button: UIButton) -> [any AccessibilityError] {
        var errors: [AccessibilityError] = []
        let defaultAccessibilityLabel = button.currentTitle
        let actualAccessibilityLabel = button.accessibilityLabel
        
        if actualAccessibilityLabel == nil, defaultAccessibilityLabel == nil {
           errors.append(AccessibilityLabelError.labelIsMissing)
        } else if let actualAccessibilityLabel {
            errors.append(contentsOf: button.checkAccessiblityLabel(actualAccessibilityLabel))
        } else if let defaultAccessibilityLabel {
            errors.append(contentsOf: button.checkAccessiblityLabel(defaultAccessibilityLabel))
        }

        if let hint = button.accessibilityHint {
            errors.append(contentsOf: button.checkAccessibilityHint(hint))
        }
        return errors
    }
    
    func test(_ button: UIButton) -> Bool {
        check(button).isEmpty ? true : false
    }
}
