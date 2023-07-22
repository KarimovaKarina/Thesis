import UIKit
import MoonPresentation
import Combine

internal class WelcomeViewController: UIViewController {
    var subscriptions = Set<AnyCancellable>()
    
    private let welcomeView = WelcomeView()
    private let evenSubject = PassthroughSubject<WelcomeEvent, Never>()
    
    override func loadView() {
        super.loadView()
        view = welcomeView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(checkForOrientation),
            name: UIApplication.willEnterForegroundNotification,
            object: nil
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkForOrientation()
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        checkForOrientation()
    }
    
    @objc  private func checkForOrientation() {
        let orientation = UIDevice.current.orientation
        
        switch orientation {
        case .landscapeRight:
            print("landscapeRight")
            welcomeView.layoutForLandscapeRight()
            
        case .landscapeLeft:
            print("landscapeLeft")
            welcomeView.layoutForLandscapeLeft()
            
        default:
            print("default")
            welcomeView.layoutForPortrait()
        }
    }
    
    func bind(_ state: AnyPublisher<WelcomeState, Never>) -> AnyPublisher<WelcomeEvent, Never> {
        welcomeView.logInDidTap
            .sink(receiveValue: { [evenSubject] in evenSubject.send(.userDidTapLogin) })
            .store(in: &subscriptions)
        
        welcomeView.registerDidTap
            .sink(receiveValue: { [evenSubject] in evenSubject.send(.userDidTapRegister) })
            .store(in: &subscriptions)
        
        return evenSubject.eraseToAnyPublisher()
    }
}

