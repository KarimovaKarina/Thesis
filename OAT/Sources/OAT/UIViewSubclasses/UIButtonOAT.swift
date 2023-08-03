import XCTest
import UIKit

private let checker = UIButtonOAT()
private let imageViewChecker = UIImageViewOAT()

public enum ExcludedChecks {
    case images
}

public extension UIView {
    func check() {
        checkAccessibility(self)
    }
}
public func checkAccessibility(
    _ view: UIView,
    exclude: ExcludedChecks? = nil,
    file: StaticString = #file,
    testName: String = #function,
    line: UInt = #line
) {
    var errors: [AccessibilityError] = []
    if let textInput = view as? UITextInput {
        errors = UITextInputOAT().check(textInput)
    }
    if let button = view as? UIButton {
        errors = checker.check(button)
    } else if let imageView = view as? UIImageView, exclude != .images {
        errors = imageViewChecker.check(imageView)
    }
    
    errors.forEach { error in
        XCTFail(error.errorMessage, file: file, line: line)
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
        
        if let hint = button.accessibilityHint, let label = button.accessibilityLabel ?? button.currentTitle {
            if hint.contains(label + " ") {
                errors.append(AccessibilityHintError.containsLabel)
            }
        }
        
        return errors
    }
    
    func test(_ button: UIButton) -> Bool {
        check(button).isEmpty ? true : false
    }
}
