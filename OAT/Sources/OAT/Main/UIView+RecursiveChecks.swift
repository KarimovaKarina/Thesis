import UIKit

extension UIView {
    private var internalClassNames: [String] {
        ["UIButtonLabel"]
    }
    
    func recursiveCheck(with excluding: [ExcludedChecks]) -> [any AccessibilityError] {
        guard
            !excluding.shouldBeExcluded(self),
//            !self.isAccessibilityElement,
            !internalClassNames.contains(Self.description())
        else { return [] }
            
        let errorsOfParentView = self.check()

        if self.isAccessibilityElement {
            return errorsOfParentView
        }
        
        let errorsOfChildViews =
        subviews
            .map { $0.recursiveCheck(with: excluding) }
            .flatMap { $0 }

        return errorsOfParentView + errorsOfChildViews
    }
}
