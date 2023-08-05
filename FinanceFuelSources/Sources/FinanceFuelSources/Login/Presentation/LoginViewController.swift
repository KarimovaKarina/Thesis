import UIKit
import Combine

internal class LoginViewController: UIViewController {
    var subscriptions = Set<AnyCancellable>()
    
    private let loginView = LoginView(mainLabelTitle: "", buttonTitle: "LOG IN")
    private let evenSubject = PassthroughSubject<LoginEvent, Never>()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
    }
    
    override func loadView() {
        super.loadView()
        view = loginView
    }
    
    func bind(_ state: AnyPublisher<LoginState, Never>) -> AnyPublisher<LoginEvent, Never> {
        loginView.logInDidTap
            .sink(receiveValue: { [evenSubject] in evenSubject.send(.userDidTapRegister($0)) })
            .store(in: &subscriptions)
        
        loginView.termsAndConditionsDidTap
            .sink(receiveValue: { [evenSubject] _ in evenSubject.send(.userDidTapTermsAndConditions) })
            .store(in: &subscriptions)
        
        state
            .compactMap(\.emailError)
            .sink(receiveValue: { [weak self] in self?.showAlert($0) })
            .store(in: &subscriptions)
        
        state
            .compactMap(\.error)
            .sink(receiveValue: { [weak self] in self?.showAlert($0.localizedDescription) })
            .store(in: &subscriptions)
        
        return evenSubject.eraseToAnyPublisher()
    }
    
    private func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
}
