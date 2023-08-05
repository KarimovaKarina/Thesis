@testable import OAT

extension AccessibilityHintError: CaseIterable {
    public static var allCases: [AccessibilityHintError] {
        [
            .hintIsEmpty,
            .containsLabel,
            .containsType(["button"]),
            .doesNotEndsWithPeriod,
            .firstWordIsNotCapitalized
        ]
    }
}
