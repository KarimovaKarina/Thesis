import UIKit
import Combine
import CombineCocoa

internal final class WelcomeView: UIView {
    var logInDidTap: AnyPublisher<Void, Never> {
        logInButton.tapPublisher
    }
    
    var registerDidTap: AnyPublisher<Void, Never> {
        registerButoon.tapPublisher
    }
    
    private let iconView = UIImageView()
    private let logInButton = AccessibleButton(title: "LOG IN", color: .white, titleColor: .black)
    private let registerButoon = AccessibleButton(title: "REGISTER", color: .black, titleColor: .white)
    private lazy var buttonsStack = UIStackView()
    private var portraitContraints: [NSLayoutConstraint]?
    private var landscapeRightContraints: [NSLayoutConstraint]?
    private var landscapeLeftContraintss: [NSLayoutConstraint]?
    
    init() {
        super.init(frame: .zero)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .mainColor
        
        iconView.image = UIImage(named: "mainIcon")
    }
    
    private func layout() {
        addSubview(iconView)
        iconView.constrain(centerTo: self.safeAreaLayoutGuide)

        buttonsStack.axis = .horizontal
        buttonsStack.spacing = .edges
        buttonsStack.distribution = .fillEqually

        buttonsStack.addArrangedSubviews([logInButton, registerButoon])
        addSubview(buttonsStack)
        
        portraitContraints = buttonsStack.constrain(.all(except: .top), to: self.safeAreaLayoutGuide, constant: .edges)
        portraitContraints?.append(buttonsStack.constrain(.height, .greaterThanOrEqual, constant: 50))
        
        landscapeRightContraints = buttonsStack.constrain(.all(except: .right), to: self.safeAreaLayoutGuide, constant: .edges)
        landscapeLeftContraintss = buttonsStack.constrain(.all(except: .left), to: self.safeAreaLayoutGuide, constant: .edges)
        
        layoutForPortrait()
    }
    
    func layoutForLandscapeRight() {
        buttonsStack.axis = .vertical
        portraitContraints?.forEach{ $0.isActive = false }
        landscapeLeftContraintss?.forEach{ $0.isActive = false }
        landscapeRightContraints?.forEach{ $0.isActive = true }
    }
    
    func layoutForLandscapeLeft() {
        buttonsStack.axis = .vertical
        portraitContraints?.forEach{ $0.isActive = false }
        landscapeRightContraints?.forEach{ $0.isActive = false }
        landscapeLeftContraintss?.forEach{ $0.isActive = true }
    }
    
    func layoutForPortrait() {
        buttonsStack.axis = traitCollection.preferredContentSizeCategory.isAccessibilityCategory
            ? .vertical
            : .horizontal
        landscapeRightContraints?.forEach{ $0.isActive = false }
        landscapeLeftContraintss?.forEach{ $0.isActive = false }
        portraitContraints?.forEach{ $0.isActive = true }
    }
}
