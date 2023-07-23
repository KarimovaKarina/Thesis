import UIKit

class UIImageViewOAT: UIImageView {
    func check(_ imageView: UIImageView) -> [any AccessibilityError] {
        var errors: [AccessibilityError] = []
       
        if !imageView.isAccessibilityElement {
            errors.append(AccessibilityElementError.isNotAccessibilityElement)
        }
        
        if let label = imageView.accessibilityLabel {
            errors.append(contentsOf: imageView.checkAccessiblityLabel(label))
        } else {
            errors.append(AccessibilityLabelError.labelIsMissing)
        }
        
        return errors
    }
}
