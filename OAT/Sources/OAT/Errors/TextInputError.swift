import UIKit

enum TextInputError {
    case keyboardAndContentTypeAreNotMatching(UIKeyboardType, UITextContentType)
}

extension TextInputError: AccessibilityError {
    var errorMessage: String {
        switch self {
        case let .keyboardAndContentTypeAreNotMatching(keyboardType, textContentType):
            return "keyboardType should be set to \(keyboardType) for defined textContentType \(textContentType)"
        }
    }
}
