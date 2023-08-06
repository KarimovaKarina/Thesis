import UIKit

extension UIView: AccessibilityCheckable {
    func check() -> [any AccessibilityError] {
        var errors: [AccessibilityError] = []

        errors += checkAccessiblityLabel()
        errors += checkAccessibilityHint()
        errors += checkSubclasses()
        
        return errors
    }
    
    private func checkSubclasses() -> [any AccessibilityError] {
        var errors: [AccessibilityError] = []
        if let textView = self as? UITextView {
            errors += textView.customCheck()
            
        } else if let label = self as? UILabel {
            errors += label.customCheck()
            
        } else if let button = self as? UIButton {
            errors += button.checkTitleAndBackgroundColor()
            
        } else if let textField = self as? UITextField {
            errors += textField.customCheck()
        }
        
        return errors
    }
}
