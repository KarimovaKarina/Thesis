import XCTest
import UIKit

private let checker = UIButtonOAT()

public extension UIView {
    func check() {
        checkAccessibility(self)
    }
}

public func checkAccessibility(
    _ view: UIView,
    file: StaticString = #file,
    testName: String = #function,
    line: UInt = #line
) {
    if let button = view as? UIButton {
        switch checker.check(button) {
        case .success:
            break

        case .failure(let error):
            XCTFail(error.errorMessage, file: file, line: line)
        }
    }
}

class UIButtonOAT {
    func check(_ button: UIButton) -> Result<Void, AccessibilityLabelError> {
        let defaultAccessibilityLabel = button.currentTitle
        let actualAccessibilityLabel = button.accessibilityLabel
        
        if actualAccessibilityLabel == nil, defaultAccessibilityLabel == nil {
            return .failure(.labelIsMissing)
        } else if let actualAccessibilityLabel {
            return check(actualAccessibilityLabel)
        } else if let defaultAccessibilityLabel {
            return check(defaultAccessibilityLabel)
        }

        return .success(())
    }
    
    private func check(_ accessiblityLabel: String) -> Result<Void, AccessibilityLabelError> {
        guard !accessiblityLabel.isEmpty else {
            return .failure(.labelIsEmpty)
        }
        
        guard let firstLetter = accessiblityLabel.first, firstLetter.isUppercase else {
            return .failure(.firstWordIsNotCapitalized)
        }
        
        guard let lastCharacter = accessiblityLabel.last, lastCharacter != "." else {
            return .failure(.endsWithPeriod)
        }
       
        let stopWords = AccessibilityLabelError.stopWords.filter{ accessiblityLabel.contains($0)}
        if !stopWords.isEmpty {
            return .failure(.containsType(stopWords))
        }
        
        return .success(())
    }
    
    func test(_ button: UIButton) -> Bool {
        switch check(button) {
        case .success:
            return true
            
        case .failure:
            return false
        }
    }
}

