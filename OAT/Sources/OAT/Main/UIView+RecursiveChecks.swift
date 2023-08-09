import UIKit

extension UIView {
    static var internalClassNames: [String] {
        ["UIButtonLabel"]
    }
    
    func recursiveCheck(with excluding: [ExcludedChecks]) -> [any AccessibilityError] {
        guard
            !excluding.shouldBeExcluded(self),
            !Self.internalClassNames.contains(Self.description())
        else { return [] }
            
        let errorsOfParentView = self.check()
       
        let errorsOfChildViews = subviews
            .map { $0.recursiveCheck(with: excluding) }
            .flatMap { $0 }

        return errorsOfParentView + errorsOfChildViews
    }
}
