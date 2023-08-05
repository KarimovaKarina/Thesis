import Foundation

internal enum LoginEvent {
    case userDidTapLogin((String?, String?))
    case userDidTapRegister((String?, String?))
    case userDidTapTermsAndConditions
}
