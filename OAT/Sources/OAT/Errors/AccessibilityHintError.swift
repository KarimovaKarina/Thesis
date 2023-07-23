enum AccessibilityHintError: Error {
    case containsType([String])
    case firstWordIsNotCapitalized
    case endsWithPeriod
}
