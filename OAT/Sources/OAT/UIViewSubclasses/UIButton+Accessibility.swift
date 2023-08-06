import UIKit

extension UIButton {
    func getDafaultValue() -> [any AccessibilityError] {
        var errors: [AccessibilityError] = []
        let defaultAccessibilityLabel = self.titleLabel?.text ?? self.currentTitle
    
        if defaultAccessibilityLabel == nil {
            errors.append(AccessibilityLabelError.labelIsMissing)
            
        } else if let defaultAccessibilityLabel {
            errors.append(contentsOf: self.checkCommonAccessibility(accessibilityLabel: defaultAccessibilityLabel))
        }

//        if let hint = self.accessibilityHint {
//            errors.append(contentsOf: self.checkAccessibilityHint(hint))
//        }
//
//        if let hint = self.accessibilityHint, let label = self.accessibilityLabel ?? self.currentTitle {
//            if hint.contains(label + " ") {
//                errors.append(AccessibilityHintError.containsLabel)
//            }
//        }
        
        return errors
    }
    
    func checkTitleAndBackgroundColor() -> [any AccessibilityError]  {
        guard self.isEnabled,
              let font = self.titleLabel?.font.pointSize,
              let isBold = self.titleLabel?.font.fontDescriptor.symbolicTraits.contains(.traitBold)
        else { return [] }
        let conditionFont: CGFloat = isBold ? 14 : 18
        let minimumContrast = font < conditionFont ? 4.5 / 1 : 3.0 / 1
        let titleColor = self.titleLabel?.textColor ?? currentTitleColor
        if let backgroundColor = self.backgroundColor {
            let actualContrast = UIColor.contrastRatio(between: titleColor, and: backgroundColor)
            return actualContrast < minimumContrast ? [ContrastError.contrastRatioSmallText] : []
        } else {
            return []
        }
    }

}
