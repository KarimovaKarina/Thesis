import XCTest
import UIKit

private let checker = UIButtonOAT()
private let imageViewChecker = UIImageViewOAT()

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
    if let control = view as? UIControl {
        checkUIControl(control, file: file, testName: testName, line: line)
    } else if let imageView = view as? UIImageView {
        checkUIImageView(imageView, file: file, testName: testName, line: line)
    }
}

func checkUIImageView(
    _ imageView: UIImageView,
    file: StaticString = #file,
    testName: String = #function,
    line: UInt = #line
) {
    switch imageViewChecker.check(imageView) {
        case .success:
            break

        case .failure(let error):
                XCTFail(error.errorMessage, file: file, line: line)
    }
}

func checkUIControl(
    _ view: UIControl,
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
        
        guard accessiblityLabel.isCapitalized() else {
            return .failure(.firstWordIsNotCapitalized)
        }
        
        guard !accessiblityLabel.endsWithPeriod() else {
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
