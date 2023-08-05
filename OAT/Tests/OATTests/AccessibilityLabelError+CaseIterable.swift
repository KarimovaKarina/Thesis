@testable import OAT

extension AccessibilityLabelError: CaseIterable {
    public static var allCases: [AccessibilityLabelError] {
        [
            .labelIsMissing,
            .labelIsEmpty,
            .firstWordIsNotCapitalized,
            .endsWithPeriod,
            .containsType(["button"])
        ]
    }
}
