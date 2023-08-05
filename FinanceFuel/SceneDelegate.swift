import UIKit
import FinanceFuelSources
import Firebase
import Combine

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var rootComponent: RootComponent?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        
        self.rootComponent = RootComponent(
            window: window,
            register: register
        )
        rootComponent?.start()
    }
    
    private func register(_ user: UserData) -> AnyPublisher<Void, Error> {
        let result = PassthroughSubject<Void, Error>()
        Auth.auth().createUser(withEmail: user.email, password: user.password) { authResult, error in
            if let error = error {
                result.send(completion: .failure(error))
            } else {
                result.send(())
            }
        }
        return result.eraseToAnyPublisher()
    }
}

