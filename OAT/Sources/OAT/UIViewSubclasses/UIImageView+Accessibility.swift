import UIKit

extension UIImageView {
    func customCheck() -> [any AccessibilityError] {
        var errors: [AccessibilityError] = []
       
        if !self.isAccessibilityElement {
            errors.append(AccessibilityElementError.isNotAccessibilityElement)
        }

        return errors
    }
}
