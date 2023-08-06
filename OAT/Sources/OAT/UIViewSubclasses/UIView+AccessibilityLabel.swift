import UIKit

extension UIView {
    func checkAccessiblityLabel() -> [any AccessibilityError] {
        if self is UIButton {
            return []
        } else {
            return checkCommonAccessibility(accessibilityLabel: accessibilityLabel)
        }
    }
    
    func checkCommonAccessibility(accessibilityLabel: String?)
    -> [any AccessibilityError] {
        guard let accessibilityLabel = accessibilityLabel else {
            return [AccessibilityLabelError.labelIsMissing]
        }
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
