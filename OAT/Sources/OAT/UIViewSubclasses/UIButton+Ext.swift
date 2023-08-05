import UIKit

extension UIButton: AccessibilityCheckable {
    func check() -> [any AccessibilityError] {
        let button = self
        var errors: [AccessibilityError] = []
        let defaultAccessibilityLabel = button.titleLabel?.text ?? button.currentTitle
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
    
    func isAccessible() -> Bool {
        check().isEmpty ? true : false
    }
}
