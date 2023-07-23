enum AccessibilityElementError: Error {
    case isNotAccessibilityElement
}

extension AccessibilityElementError: AccessibilityError {
    var errorMessage: String {
        switch self {
        case .isNotAccessibilityElement:
            return "This element is not accessibilityElement by default. If it contains important content, set isAccessibilityElement property to true, otherwise disable this error"
        }
    }
}
