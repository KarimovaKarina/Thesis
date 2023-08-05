import UIKit

extension UITextView: AccessibilityCheckable {
    func check() -> [any AccessibilityError] {
        checkKeyboardAndContentType() + attributedText.checkAttributedString()
    }
    
    private func checkAttributedString() -> [any AccessibilityError] {
        self.attributedText.map{ $0.checkAttributedString() } ?? []
    }
}
