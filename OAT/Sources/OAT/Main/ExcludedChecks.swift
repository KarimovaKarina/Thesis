public enum ExcludedChecks {
    case images
}

import UIKit

extension ExcludedChecks {
    func shouldBeExcluded(_ item: AccessibilityCheckable) -> Bool {
        switch self {
        case .images:
            return item is UIImageView
//            if let item = item as? UIImageView {
//                return true
//            }
        }
    }
}


extension Array where Element == ExcludedChecks {
    
}

extension [ExcludedChecks] {

    func shouldBeExcluded(_ item: AccessibilityCheckable) -> Bool {
        
        for rule in self {
            if rule.shouldBeExcluded(item) {
                return true
            }
        }
        
        return false
    }
    
}
