enum AccessibilityTraitError: Error {
    case isMissing
}

extension AccessibilityTraitError: AccessibilityError {
    var errorMessage: String {
        switch self {
        case .isMissing:
            return "AccessiblityTrait is missing"
        }
    }
}
