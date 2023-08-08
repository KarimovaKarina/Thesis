import UIKit

extension UIView: AccessibilityCheckable {
    func check() -> [any AccessibilityError] {
        if self is UIControl {
            return checkAccessibleElement()
        } else if self is UIImageView {
            guard isAccessibilityElement else {
                return [AccessibilityElementError.isNotAccessibilityElement(self)]
            }
            return checkAccessibleElement()
        } else {
            guard isAccessibilityElement else { return [] }
            return checkAccessibleElement()
        }
    }
    
    private func checkAccessibleElement() -> [any AccessibilityError] {
        var errors: [AccessibilityError] = []
        
//        errors += checkDuplicates()
        errors += checkAccessiblityLabel()
        errors += checkAccessibilityHint()
        errors += checkTraitsConflict()
        errors += checkSubclasses()
        
        return errors
    }
    
    private func checkSubclasses() -> [any AccessibilityError] {
        var errors: [AccessibilityError] = []
        if let textView = self as? UITextView {
            errors += textView.customCheck()
            
        } else if let label = self as? UILabel {
            errors += label.customCheck()
            
        } else if let button = self as? UIButton {
            errors += button.customChecks()
            
        } else if let textField = self as? UITextField {
            errors += textField.customCheck()
        }
        
        return errors
    }
}

extension NSObject {
    var className: String {
        Self.description()
//        String(describing: type(of: self))
    }
}
extension UIView {
    static private func subviewLabels(for view: UIView) -> [String] {
        guard !Self.internalClassNames.contains(view.className)
        else { return [] }
        let parentLabel = [view.actualAccessibilityLabel]
        let childLabels = view.subviews.map { subviewLabels(for: $0) }.flatMap { $0 }
        return (parentLabel + childLabels).compactMap { $0 }
    }
    
    static func checkDuplicates(for view: UIView) -> [any AccessibilityError] {
        var labelsSet = Set<String>()
        let labels = subviewLabels(for: view)
        var duplicate = [String]()
        labels.forEach { label in
            if labelsSet.contains(label) {
                duplicate.append(label)// = label
            } else {
                labelsSet.insert(label)
            }
        }
                        
//        guard let duplicate = duplicate
//        else { return [] }

        return duplicate.map { AccessibilityLabelError.duplicated(view, $0) }
    }
}
