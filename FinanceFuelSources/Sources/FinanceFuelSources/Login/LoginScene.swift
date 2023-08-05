import Moonlight
import UIKit
import Combine

internal struct LoginScene {
    static func start(
        rootViewController: UIViewController,
        register: @escaping (UserData) -> AnyPublisher<Void, Error>,
        showTermsAndConditions: @escaping (UIViewController) -> Void,
        makeHomeScene: @escaping () -> Void
    ) {
        let vc = LoginViewController()
        
        let env = LoginEnvironment(
            register: register,
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
