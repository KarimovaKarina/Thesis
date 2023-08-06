import UIKit

enum AccessibilityLabelError {
    case labelIsMissing(UIView)
    case labelIsEmpty
    case containsType([String])
    case firstWordIsNotCapitalized
    case endsWithPeriod
    case duplicated
}

extension AccessibilityLabelError: AccessibilityError {
    var errorMessage: String {
        switch self {
        case let .labelIsMissing(type):
            return """
                    accessibilityLabel or its default value by means of
                    element title/text are missing. \n
                    UI element description: \(type.description)
            """
            
        case .labelIsEmpty:
            return "accessibilityLabel should not be empty string."

        case let .containsType(stopWords):
            return "accessibilityLabel should not include the type of the control or view. Please, substitute the following words \(stopWords)."
            
        case .firstWordIsNotCapitalized:
            return "accessibilityLabel should begin with a capitalized word. This helps VoiceOver read the label with the appropriate inflection."
            
        case .endsWithPeriod:
            return "accessibilityLabel is not a sentence and therefore should not end with a period."
            
        case .duplicated:
            return "Something is duplicated..."
        }
    }
}

extension AccessibilityLabelError {
    static var stopWords: [String] = ["button", "label"]
}
