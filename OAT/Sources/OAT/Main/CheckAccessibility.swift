import XCTest
import UIKit

public func checkAccessibility(
    _ view: UIView,
    with settings: AccessibilitySettings = .default,
    file: StaticString = #file,
    testName: String = #function,
    line: UInt = #line
) {
    guard !settings.excluding.shouldBeExcluded(view)
    else { return }
    
    let accessibilityErrors = settings.recursiveChecking
        ? view.recursiveCheck(with: settings.excluding)
        : ((view as? AccessibilityCheckable)?.check() ?? [])
    
    accessibilityErrors.forEach { error in
        XCTFail(error.errorMessage, file: file, line: line)
    }
}
