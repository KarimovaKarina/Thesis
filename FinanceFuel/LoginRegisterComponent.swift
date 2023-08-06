import UIKit
import FinanceFuelSources

struct LoginComponent {
    let parent: RootComponent
    
    func makeLoginScene(_ rootController: UIViewController) {
        LoginScene.start(
            rootViewController: rootController,
            register: parent.register,
            showTermsAndConditions: showTermsAndConditions,
            makeHomeScene: {
                let vc = TabBarController()
                let navigationController = UINavigationController(rootViewController: vc)
                parent.window.rootViewController = navigationController
            }
        )
    }
    
    func makeRegisterScene(_ rootController: UIViewController) {
        LoginScene.start(
            rootViewController: rootController,
            register: parent.register,
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
