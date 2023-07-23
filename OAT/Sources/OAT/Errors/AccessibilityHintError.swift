enum AccessibilityHintError: Error {
    case containsType([String])
    case firstWordIsNotCapitalized
    case endsWithPeriod
}

extension AccessibilityHintError: AccessibilityError {
    var errorMessage: String {
        switch self {
        case let .containsType(stopWords):
            return "accessibilityLabel should not include the type of the control or view. Please, substitute the following words \(stopWords)."
            
        case .firstWordIsNotCapitalized:
            return "accessibilityLabel should begin with a capitalized word. This helps VoiceOver read the label with the appropriate inflection."
            
        case .endsWithPeriod:
            return "The label is not a sentence and therefore should not end with a period."
        }
    }
}

extension AccessibilityHintError {
    static var stopWords: [String] = ["button", "label"]
}
