import UIKit
import Combine

public struct RootComponent {
    let window: UIWindow
    let register: (UserData) -> AnyPublisher<Void, Error>
    
    public init(
        window: UIWindow,
        register: @escaping (UserData) -> AnyPublisher<Void, Error>
) {
        self.window = window
        self.register = register
    }
    
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
