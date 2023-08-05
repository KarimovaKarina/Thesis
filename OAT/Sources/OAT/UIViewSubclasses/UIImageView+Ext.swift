import UIKit

extension UIImageView: AccessibilityCheckable {
    func check() -> [any AccessibilityError] {
        var errors: [AccessibilityError] = []
       
        if !self.isAccessibilityElement {
            errors.append(AccessibilityElementError.isNotAccessibilityElement)
        }
        
        if let label = self.accessibilityLabel {
            errors.append(contentsOf: self.checkAccessiblityLabel(label))
        } else {
            errors.append(AccessibilityLabelError.labelIsMissing)
        }
        
        return errors
    }
}
