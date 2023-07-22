import Moonlight
import UIKit

internal struct SettingsScene {
    static func start(
        openTechSupportScene: @escaping(UIViewController) -> Void
    ) -> UIViewController {
        let vc = SettingsViewController()
        
        let env = SettingsEnvironment(openTechSupportScene: {openTechSupportScene(vc)})
        let state = SettingsState()
        
        Moonlight.start(
            initialState: state,
            environment: env,
            feedback: vc.bind,
            transform: SettingsReducer.transform,
            apply: SettingsReducer.apply
        )
        .store(in: &vc.subscriptions)
        
        return vc
    }
}
