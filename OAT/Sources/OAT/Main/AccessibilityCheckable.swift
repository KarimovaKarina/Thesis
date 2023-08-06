import UIKit

protocol AccessibilityCheckable {
    func check() -> [any AccessibilityError]
}

extension AccessibilityCheckable {
    func isAccessible() -> Bool {
        check().isEmpty
    }
}


extension UIView {
    private var internalClassNames: [String] {
        ["UIButtonLabel"]
    }
    
    func recursiveCheck(with excluding: [ExcludedChecks]) -> [any AccessibilityError] {
        guard
            !excluding.shouldBeExcluded(self),
            !self.isAccessibilityElement,
            !internalClassNames.contains(Self.description())
        else { return [] }
            
        let errorsOfParentView = (self as? AccessibilityCheckable)?.check() ?? []

        let errorsOfChildViews =
        subviews
            .map { $0.recursiveCheck(with: excluding) }
            .flatMap { $0 }

        return errorsOfParentView + errorsOfChildViews
    }
}
