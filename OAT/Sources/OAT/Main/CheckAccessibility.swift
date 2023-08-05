import XCTest
import UIKit

public func checkAccessibility(
    _ view: UIView,
    exclude: ExcludedChecks? = nil,
    file: StaticString = #file,
    testName: String = #function,
    line: UInt = #line
) {
    var errors: [AccessibilityError] = []
    
    guard let checkable = view as? AccessibilityCheckable
    else { return }
    
    errors += checkable.check()
    
    errors.forEach { error in
        XCTFail(error.errorMessage, file: file, line: line)
    }
}
