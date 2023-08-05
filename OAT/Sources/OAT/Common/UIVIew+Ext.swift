import UIKit

extension UIView {
    func checkAccessiblityLabel(_ accessiblityLabel: String) -> [any AccessibilityError] {
        guard !accessiblityLabel.isEmpty else {
            return [AccessibilityLabelError.labelIsEmpty]
        }
        
        var errors: [AccessibilityError] = []
        if !accessiblityLabel.isCapitalized() {
            errors.append(AccessibilityLabelError.firstWordIsNotCapitalized)
        }
        
        if accessiblityLabel.endsWithPeriod() {
            errors.append(AccessibilityLabelError.endsWithPeriod)
        }
       
        let stopWords = AccessibilityLabelError.stopWords.filter{ accessiblityLabel.lowercased().contains($0)}
        if !stopWords.isEmpty {
            errors.append(AccessibilityLabelError.containsType(stopWords))
        }
        
        return errors
    }
    
    func checkAccessibilityHint(_ accessiblityHint: String) -> [any AccessibilityError] {
        guard !accessiblityHint.isEmpty else {
            return [AccessibilityHintError.hintIsEmpty]
        }
        
        var errors: [AccessibilityError] = []

        if !accessiblityHint.isCapitalized() {
            errors.append(AccessibilityHintError.firstWordIsNotCapitalized)
        }
        
        if !accessiblityHint.endsWithPeriod() {
            errors.append(AccessibilityHintError.doesNotEndsWithPeriod)
        }
       
        let stopWords = AccessibilityHintError.stopWords.filter{ accessiblityHint.contains($0)}
        if !stopWords.isEmpty {
            errors.append(AccessibilityLabelError.containsType(stopWords))
        }
        
        return errors
    }
}
