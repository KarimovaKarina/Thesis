import Moonlight
import UIKit

internal struct LoginScene {
    static func start(
        rootViewController: UIViewController,
        makeHomeScene: @escaping () -> Void
    ) {
        let vc = LoginViewController()
        
        let env = LoginEnvironment(makeHomeScene: makeHomeScene)
        let state = LoginState()
        
        Moonlight.start(
            initialState: state,
            environment: env,
            feedback: vc.bind,
            transform: LoginReducer.transform,
            apply: LoginReducer.apply
        )
        .store(in: &vc.subscriptions)
        rootViewController.show(vc, sender: nil)
    }
}
