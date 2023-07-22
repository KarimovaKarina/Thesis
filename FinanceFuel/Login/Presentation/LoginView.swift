import UIKit
import Combine
import CombineCocoa

internal final class LoginView: UIView {
    var logInDidTap: AnyPublisher<Void, Never> {
        loginButton.tapPublisher
    }
    
    private let mainLabelTitle: String
    private let buttonTitle: String
    private let mainLabel = UILabel()
    private let usernameTextField = UITextField()
    private let passwordTextField = UITextField()
    private let stackView = UIStackView()
    private lazy var loginButton = AccessibleButton(title: buttonTitle, color: .black, titleColor: .white)
    
    init(mainLabelTitle: String, buttonTitle: String) {
        self.mainLabelTitle = mainLabelTitle
        self.buttonTitle = buttonTitle
        super.init(frame: .zero)
        
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        mainLabel.text = mainLabelTitle
        usernameTextField.placeholder = "Username"
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
        [usernameTextField, passwordTextField, loginButton].forEach { subview in
            subview.constrain(.height, constant: 50)
            stackView.addArrangedSubview(subview)
        }
        
        stackView.constrain([.left, .right], to: self.safeAreaLayoutGuide, constant: .edges)
        stackView.constrain(.vertical, to: self)
    }
}
