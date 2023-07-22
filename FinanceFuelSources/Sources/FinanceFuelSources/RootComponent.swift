import UIKit

public struct RootComponent {
    public init(window: UIWindow) {
        self.window = window
    }
    
    let window: UIWindow
    
    public func start() {
        WelcomeComponent(parent: self)
            .makeWelcomeScene(setViewComtroller: setViewComtroller)
    }
    
    private func setViewComtroller(_ vc: UIViewController) {
        let navigationController = UINavigationController(rootViewController: vc)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
