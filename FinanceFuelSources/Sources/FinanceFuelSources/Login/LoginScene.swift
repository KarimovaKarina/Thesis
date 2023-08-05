import Moonlight
import UIKit

internal struct LoginScene {
    static func start(
        rootViewController: UIViewController,
        showTermsAndConditions: @escaping (UIViewController) -> Void,
        makeHomeScene: @escaping () -> Void
    ) {
        let vc = LoginViewController()
        
        let env = LoginEnvironment(
            makeHomeScene: makeHomeScene,
            showTermsAndConditions: {showTermsAndConditions(vc) }
        )
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
