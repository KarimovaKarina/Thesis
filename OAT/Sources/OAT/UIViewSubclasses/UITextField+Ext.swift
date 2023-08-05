import UIKit

extension UITextField: AccessibilityCheckable {
    func check() -> [any AccessibilityError] {
        checkKeyboardAndContentType()
    }
}
