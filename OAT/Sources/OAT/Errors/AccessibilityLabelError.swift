enum AccessibilityLabelError: Error {
    case labelIsMissing
    case labelIsEmpty
    case containsType([String])
    case firstWordIsNotCapitalized
    case endsWithPeriod
}

extension AccessibilityLabelError {
    var errorMessage: String {
        switch self {
        case .labelIsMissing:
            return "accessibilityLabel and its default value by means of element title/text are missing."
            
        case .labelIsEmpty:
            return "Label is empty string."

        case let .containsType(stopWords):
            return "accessibilityLabel should not include the type of the control or view. Please, substitute the following words \(stopWords)."
            
        case .firstWordIsNotCapitalized:
            return "accessibilityLabel should begin with a capitalized word. This helps VoiceOver read the label with the appropriate inflection."
            
        case .endsWithPeriod:
            return "The label is not a sentence and therefore should not end with a period."
        }
    }
}

extension AccessibilityLabelError {
    static var stopWords: [String] = ["button", "label"]
}