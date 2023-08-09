@testable import FinanceFuelSources
import Foundation

extension AccessibleButton {
    convenience init() {
        self.init(
            title: "button .",
            hint: "button opens link",
            color: .black,
            titleColor: .blue
        )
    }
}

var accessibleButton: AccessibleButton = {
    let button = AccessibleButton()
    button.accessibilityTraits.insert(.link)
    button.frame = CGRect(x: 0, y: 0, width: 30, height: 40)
    return button
}()
