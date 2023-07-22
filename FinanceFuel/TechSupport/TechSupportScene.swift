import Moonlight
import UIKit

internal struct TechSupportScene {
    static func start(
        rootViewController: UIViewController
    ) {
        let vc = TechSupportViewController()
        
        let env = TechSupportEnvironment()
        let state = TechSupportState()
        
        Moonlight.start(
            initialState: state,
            environment: env,
            feedback: vc.bind,
            transform: TechSupportReducer.transform,
            apply: TechSupportReducer.apply
        )
        .store(in: &vc.subscriptions)
        
        rootViewController.show(vc, sender: nil)
    }
}
