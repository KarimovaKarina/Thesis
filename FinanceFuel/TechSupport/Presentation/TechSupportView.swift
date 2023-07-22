import UIKit

internal class TechSupportView: UIView {
    private let titleLabel = UILabel()
    private let messageInputView = UITextView()
    private let sendButton = AccessibleButton(title: "Send", color: .mainColor, titleColor: .black)
    
    init() {
        super.init(frame: .zero)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .white
        titleLabel.numberOfLines = 0
        titleLabel.text = "Please feel free to contact us if you faced with technical issues"
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        
        messageInputView.backgroundColor = .textInputColor
        messageInputView.layer.cornerRadius = 10
    }
    
    private func layout() {
        addSubview(titleLabel)
        titleLabel.constrain(.all(except: .bottom), to: self.safeAreaLayoutGuide, constant: .edges)
        
        addSubview(sendButton)
        sendButton.constrain(.all(except: .top), to: self.safeAreaLayoutGuide, constant: .edges)
        
        addSubview(messageInputView)
        messageInputView.constrain([.left, .right], to: self.safeAreaLayoutGuide, constant: .edges)
        messageInputView.constrain(.top, to: titleLabel, edge: .bottom, constant: .edges)
        messageInputView.constrain(.bottom, to: sendButton, edge: .top, constant: -.edges)
    }
}
    
