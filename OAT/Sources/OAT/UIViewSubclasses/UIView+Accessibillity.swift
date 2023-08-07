import UIKit

extension UIView: AccessibilityCheckable {
    func check() -> [any AccessibilityError] {
        if self is UIControl {
            return checkAccessibleElement()
        } else if self is UIImageView {
            guard isAccessibilityElement else {
                return [AccessibilityElementError.isNotAccessibilityElement(self)]
            }
            return checkAccessibleElement()
        } else {
            guard isAccessibilityElement else { return [] }
            return checkAccessibleElement()
        }
    }
    
    private func checkAccessibleElement() -> [any AccessibilityError] {
        var errors: [AccessibilityError] = []
        
        errors += checkAccessiblityLabel()
        errors += checkAccessibilityHint()
        errors += checkSubclasses()
        errors += checkTraitsConflict()
        
        return errors
    }
    
    private func checkSubclasses() -> [any AccessibilityError] {
        var errors: [AccessibilityError] = []
        if let textView = self as? UITextView {
            errors += textView.customCheck()
            
        } else if let label = self as? UILabel {
            errors += label.customCheck()
            
        } else if let button = self as? UIButton {
            errors += button.customChecks()
            
        } else if let textField = self as? UITextField {
            errors += textField.customCheck()
        }
        
        return errors
    }
    
    private func checkTraitsConflict() -> [any AccessibilityError] {
        var exclusiveTraits: [UIAccessibilityTraits] = []
        UIAccessibilityTraits.mutuallyExclusiveTraits.forEach { trait in
            if self.accessibilityTraits.contains(trait) {
                exclusiveTraits.append(trait)
            }
        }
        if exclusiveTraits.count <= 1 {
            return []
        } else {
            return [AccessibilityTraitError.traitsConflict(self, exclusiveTraits)]
        }
    }
}

extension UIView {
    private func subviewLabels(for view: UIView) -> [String] {
        let parentLabel = [accessibilityLabel]
        let childLabels = subviews.map { subviewLabels(for: $0) }.flatMap { $0 }
        return (parentLabel + childLabels).compactMap { $0 }
    }
    
    func recursiveCheck2() -> [any AccessibilityError] {
        let labels = subviewLabels(for: self)
    
        if Set(labels).count == labels.count {
            return []
        } else {
            return [AccessibilityLabelError.duplicated]
        }
    }
}
