import UIKit

class UITextInputOAT {
    func check(_ textInput: UITextInput) -> [any AccessibilityError] {
        var errors: [AccessibilityError] = []
       
        guard let textContentType = textInput.textContentType else {
            return []
        }
        
        guard let textContentType = textContentType else {
            return []
        }
        
        if let expectedKeyboardType = textContentType.expectedKeyboardType,
            textInput.keyboardType != expectedKeyboardType
        {
            errors.append(TextInputError.keyboardAndContentTypeAreNotMatching(expectedKeyboardType, textContentType))
        }
        
        return errors
    }
}
