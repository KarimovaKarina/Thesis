import UIKit
import FinanceFuelSources

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
        LoginComponent(parent: parent).makeLoginScene(rootController)
    }
    
    private func makeRegisterScene(_ rootController: UIViewController) {
        LoginComponent(parent: parent).makeRegisterScene(rootController)
    }
}
