enum LoginEffect {
    case nothing
    case errorOccured(Error)
    case emailError
    case passwordError
}
