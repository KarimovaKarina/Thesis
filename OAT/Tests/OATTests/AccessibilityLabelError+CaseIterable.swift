@testable import OAT
import UIKit

extension AccessibilityLabelError: CaseIterable {
    public static var allCases: [AccessibilityLabelError] {
        [
            .labelIsMissing(UIView()),
            .labelIsEmpty,
            .firstWordIsNotCapitalized,
            .endsWithPeriod,
            .containsType(["button"])
        ]
    }
}
