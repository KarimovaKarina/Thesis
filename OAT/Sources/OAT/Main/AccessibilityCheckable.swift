
protocol AccessibilityCheckable {
    func check() -> [any AccessibilityError]
}

extension AccessibilityCheckable {
    func isAccessible() -> Bool {
        check().isEmpty
    }
}

import UIKit

extension AccessibilityCheckable {
    
    func recursiveCheck(with excluding: [ExcludedChecks]) -> [any AccessibilityError] {

        guard !excluding.shouldBeExcluded(self)
        else { return [] }
            
        let errorsOfParentView = self.check()

        let errorsOfChildViews = (self as? UIView)?.subviews
            .compactMap { $0 as? AccessibilityCheckable }
            .map { $0.recursiveCheck(with: excluding) }
            .flatMap { $0 } ?? []


        return errorsOfParentView + errorsOfChildViews
        
        
    }
}
