import UIKit

public struct WelcomeComponent {
    let parent: RootComponent
    
    public func makeWelcomeScene(setViewComtroller: @escaping (UIViewController) -> Void) {
        WelcomeScene.start(
            setViewComtroller: setViewComtroller,
            makeLoginScene: makeLoginScene,
            makeRegisterScene: makeRegisterScene
        )
    }
    
    private func makeLoginScene(_ rootController: UIViewController) {
        LoginScene.start(
            rootViewController: rootController,
            makeHomeScene: {
                let vc = TabBarController()
                let navigationController = UINavigationController(rootViewController: vc)
                parent.window.rootViewController = navigationController
            }
        )
    }
    
    private func makeRegisterScene(_ rootController: UIViewController) {
        LoginScene.start(
            rootViewController: rootController,
            makeHomeScene: {
                let vc = TabBarController()
                let navigationController = UINavigationController(rootViewController: vc)
                parent.window.rootViewController = navigationController
            }
        )
    }
}
