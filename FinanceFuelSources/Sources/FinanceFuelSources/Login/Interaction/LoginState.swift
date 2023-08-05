import Foundation

internal struct LoginState {
    var email: String?
    var password: String?
    var error: Error?
    var emailError: String?
    var passwordError: String?
}
