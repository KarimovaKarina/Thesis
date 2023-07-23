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
       
        let stopWords = AccessibilityLabelError.stopWords.filter{ accessiblityLabel.contains($0)}
        if !stopWords.isEmpty {
            errors.append(AccessibilityLabelError.containsType(stopWords))
        }
        
        return errors
    }
}
