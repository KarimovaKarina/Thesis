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
    
    func checkAttributedString(_ textInput: UIView) -> [any AccessibilityError] {
        if let label = textInput as? UILabel {
            return label.attributedText.map{ $0.checkAttributedString() } ?? []
        } else if let textView = textInput as? UITextView {
            return textView.attributedText.map{ $0.checkAttributedString() } ?? []
        } else {
            return []
        }
    }
}
