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
            showTermsAndConditions: showTermsAndConditions,
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
            showTermsAndConditions: showTermsAndConditions,
            makeHomeScene: {
                let vc = TabBarController()
                let navigationController = UINavigationController(rootViewController: vc)
                parent.window.rootViewController = navigationController
            }
        )
    }
    
    private func showTermsAndConditions(_ viewController: UIViewController) {
        let termsViewController = UIViewController()
        let html = "<html><body><p>Terms and conditions!</p></body></html>"
        termsViewController.view = TermsAndConditionsView(downloadedContent: html)

        viewController.navigationController?.present(termsViewController, animated: true)
    }
}
