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
        errors.append(contentsOf: UITextInputOAT().check(textInput))
    }
    if let label = view as? UILabel {
        errors.append(contentsOf: UITextInputOAT().checkAttributedString(label))
    }
    if let textView = view as? UITextView {
        errors.append(contentsOf: UITextInputOAT().checkAttributedString(textView))
    }
    if let button = view as? UIButton {
        errors.append(contentsOf: checker.check(button))
    } else if let imageView = view as? UIImageView, exclude != .images {
        errors.append(contentsOf: imageViewChecker.check(imageView))
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
        
        errors.append(contentsOf: checkTitleAndBackgroundColor(button))
        
        return errors
    }
    
    func checkTitleAndBackgroundColor(_ button: UIButton) -> [any AccessibilityError]  {
        guard button.isEnabled,
              let font = button.titleLabel?.font.pointSize,
              let isBold = button.titleLabel?.font.fontDescriptor.symbolicTraits.contains(.traitBold)
        else { return [] }
        let conditionFont: CGFloat = isBold ? 14 : 18
        let minimumContrast = font < conditionFont ? 4.5 / 1 : 3.0 / 1
        
        if let backgroundColor = button.backgroundColor {
            let actualContrast = UIColor.contrastRatio(between: button.currentTitleColor, and: backgroundColor)
            print("actualContrast == \(actualContrast) \n minimumContrast == \(minimumContrast)")
            return actualContrast < minimumContrast ? [ContrastError.contrastRatioSmallText] : []
        } else {
            return []
        }
    }
    
    func test(_ button: UIButton) -> Bool {
        check(button).isEmpty ? true : false
    }
}
