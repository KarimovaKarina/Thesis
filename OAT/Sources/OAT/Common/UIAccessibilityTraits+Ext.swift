import UIKit

extension UIAccessibilityTraits {
    static var mutuallyExclusiveTraits: [UIAccessibilityTraits] {
        [.button, .searchField, .link, .keyboardKey]
    }
    
    var stringValue: String {
        switch self {
        case .none:
            return "UIAccessibilityTraits.none"
            
        case .button:
            return "UIAccessibilityTraits.button"
            
        case .link:
            return "UIAccessibilityTraits.link"
            
        case .searchField:
            return "UIAccessibilityTraits.searchField"
            
        case .image:
            return "UIAccessibilityTraits.image"
            
        case .selected:
            return "UIAccessibilityTraits.selected"
            
        case .playsSound:
            return "UIAccessibilityTraits.playsSound"
            
        case .keyboardKey:
            return "UIAccessibilityTraits.keyboardKey"
            
        case .staticText:
            return "UIAccessibilityTraits.staticText"
            
        case .summaryElement:
            return "UIAccessibilityTraits.summaryElement"
            
        case .notEnabled:
            return "UIAccessibilityTraits.notEnabled"
            
        case .updatesFrequently:
            return "UIAccessibilityTraits.updatesFrequently"
            
        case .startsMediaSession:
            return "UIAccessibilityTraits.startsMediaSession"
            
        case .adjustable:
            return "UIAccessibilityTraits.adjustable"
            
        case .allowsDirectInteraction:
            return "UIAccessibilityTraits.allowsDirectInteraction"
            
        case .causesPageTurn:
            return "UIAccessibilityTraits.causesPageTurn"
            
        case .header:
            return "UIAccessibilityTraits.header"
            
        case .tabBar:
            return "UIAccessibilityTraits.tabBar"
            
        default:
            return "Unsupported/new"
        }
    }
}
