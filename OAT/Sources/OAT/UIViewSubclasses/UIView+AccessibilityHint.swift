import UIKit

extension UIView {    
    func checkAccessibilityHint() -> [any AccessibilityError] {
        guard let accessibilityHint = accessibilityHint else {
            return []
        }
        guard !accessibilityHint.isEmpty else {
            return [AccessibilityHintError.hintIsEmpty]
        }
        
        var errors: [AccessibilityError] = []

        if !accessibilityHint.isCapitalized() {
            errors.append(AccessibilityHintError.firstWordIsNotCapitalized)
        }
        
        if !accessibilityHint.endsWithPeriod() {
            errors.append(AccessibilityHintError.doesNotEndsWithPeriod)
        }
       
        let stopWords = AccessibilityHintError.stopWords
            .filter{ accessibilityHint.lowercased().contains($0) }
        
        if !stopWords.isEmpty {
            errors.append(AccessibilityLabelError.containsType(stopWords))
        }
        
        if let label = self.accessibilityLabel {
            if accessibilityHint.contains(label + " ") {
                errors.append(AccessibilityHintError.containsLabel)
            }
        }
        
        return errors
    }
}
