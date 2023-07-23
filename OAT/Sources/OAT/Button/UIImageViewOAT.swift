import UIKit

class UIImageViewOAT: UIImageView {
    func check(_ imageView: UIImageView) -> Result<Void, AccessibilityElementError> {
        guard imageView.isAccessibilityElement else { return .failure(.isNotAccessibilityElement) }

        return .success(())
    }
}
