import UIKit

extension UILabel: AccessibilityCheckable {
    func check() -> [AccessibilityError] {
        checkAttributedString()
    }
    
    private func checkAttributedString() -> [any AccessibilityError] {
        self.attributedText.map { $0.checkAttributedString() } ?? []
    }
}
