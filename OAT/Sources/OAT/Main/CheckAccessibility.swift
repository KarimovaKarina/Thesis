import XCTest
import UIKit

public struct AccessibilitySettings {
    
    let excluding: [ExcludedChecks]
//    let excluding
    let recursiveChecking: Bool
    // ...
    
    public  init(excluding: [ExcludedChecks], recursiveChecking: Bool) {
        self.excluding = excluding
        self.recursiveChecking = recursiveChecking
    }
}

public extension AccessibilitySettings {
    static var `default`: Self {
        .init(excluding: [], recursiveChecking: true)
    }
}

public func checkAccessibility(
    _ view: UIView,
    with settings: AccessibilitySettings = .default,
//    exclude: ExcludedChecks? = nil,
//    exclude: [ExcludedChecks] = [],
    file: StaticString = #file,
    testName: String = #function,
    line: UInt = #line
) {
    guard let checkable = view as? AccessibilityCheckable,
          !settings.excluding.shouldBeExcluded(checkable)
    else { return }
    
    let accessibilityErrors = settings.recursiveChecking
        ? checkable.recursiveCheck(with: settings.excluding)
        : checkable.check()
    
    accessibilityErrors.forEach { error in
        XCTFail(error.errorMessage, file: file, line: line)
    }
}
