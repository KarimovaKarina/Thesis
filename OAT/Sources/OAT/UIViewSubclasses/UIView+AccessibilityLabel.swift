import UIKit

extension UIView {
    func checkAccessiblityLabel() -> [any AccessibilityError] {
        guard let accessibilityLabel = accessibilityLabel else {
            if let button = self as? UIButton {
                return button.getDafaultValue()
            } else {
                return []
            }
        }
        
        var errors: [AccessibilityError] = []
        errors.append(contentsOf: checkCommonAccessibility(accessibilityLabel: accessibilityLabel))
        return errors
    }
    
    func checkCommonAccessibility(accessibilityLabel: String) -> [any AccessibilityError] {
        guard !accessibilityLabel.isEmpty else {
            return [AccessibilityLabelError.labelIsEmpty]
        }
        
        var errors: [AccessibilityError] = []
        if !accessibilityLabel.isCapitalized() {
            errors.append(AccessibilityLabelError.firstWordIsNotCapitalized)
        }
        
        if accessibilityLabel.endsWithPeriod() {
            errors.append(AccessibilityLabelError.endsWithPeriod)
        }
       
        let stopWords = AccessibilityLabelError.stopWords
            .filter{ accessibilityLabel.lowercased().contains($0) }
        if !stopWords.isEmpty {
            errors.append(AccessibilityLabelError.containsType(stopWords))
        }

        return errors
    }
}
