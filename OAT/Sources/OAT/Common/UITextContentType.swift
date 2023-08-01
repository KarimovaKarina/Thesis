import UIKit

extension UITextContentType {
    var expectedKeyboardType: UIKeyboardType? {
        switch self {
        case .emailAddress,
                .username:
            return .emailAddress
            
        case .telephoneNumber,
                .creditCardNumber:
            return .namePhonePad
            
        default:
            return nil
        }
    }
}
