import UIKit
import Moonlight

public enum WelcomeScene {
    public static func start(
        setViewComtroller: (UIViewController) -> Void,
        makeLoginScene: @escaping (UIViewController) -> Void,
        makeRegisterScene: @escaping (UIViewController) -> Void
    ) {
        let vc = WelcomeViewController()
        
        let env = WelcomeEnvironment(
            makeLoginScene: { makeLoginScene(vc) },
            makeRegisterScene: { makeRegisterScene(vc) }
        )
        
        Moonlight.start(
            initialState: .init(),
            environment: env,
            feedback: vc.bind,
            transform: WelcomeReducer.transform,
            apply: WelcomeReducer.apply
        )
        .store(in: &vc.subscriptions)
        
        setViewComtroller(vc)
    }
}
