import UIKit
import Combine
import CombineCocoa

internal final class LoginView: UIView {
    var logInDidTap: AnyPublisher<(String?, String?), Never> {
        loginButton.tapPublisher
            .map { [unowned self] _ in (usernameTextField.text, passwordTextField.text) }
            .eraseToAnyPublisher()
    }
    
    var termsAndConditionsDidTap: AnyPublisher<String, Never> {
        termsAndConditions.didTap
    }
    
    private let buttonTitle: String
    private let usernameTextField = UITextField()
    private let passwordTextField = UITextField()
    private let termsAndConditions = TappableTextView(tappableText: ["terms and conditions"], fullText: "Accept our terms and conditions")
    private let stackView = UIStackView()
    private lazy var loginButton = AccessibleButton(title: buttonTitle, color: .black, titleColor: .white)
    
    init(buttonTitle: String) {
        self.buttonTitle = buttonTitle
        super.init(frame: .zero)
        
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        usernameTextField.accessibilityLabel = "Email address"
        usernameTextField.keyboardType = .emailAddress
        passwordTextField.accessibilityLabel = "Password"

        usernameTextField.textContentType = .emailAddress
        passwordTextField.placeholder = "Password"
        passwordTextField.textContentType = .password
        
        [usernameTextField, passwordTextField].forEach { textField in
            textField.borderStyle = .roundedRect
            textField.layer.borderWidth = 2
        }
        
        backgroundColor = .white
    }
    
    private func layout() {
        addSubview(stackView)
        stackView.alignment = .fill
        stackView.spacing = 24
        stackView.axis = .vertical
        [usernameTextField, passwordTextField, termsAndConditions, loginButton].forEach { subview in
            subview.constrain(.height, constant: 50)
            stackView.addArrangedSubview(subview)
        }
        
        stackView.constrain([.left, .right], to: self.safeAreaLayoutGuide, constant: .edges)
        stackView.constrain(.vertical, to: self)
    }
}
