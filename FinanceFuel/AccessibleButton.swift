import UIKit

internal final class AccessibleButton: UIButton {
    private let title: String
    private let hint: String?
    private let color: UIColor
    private let titleColor: UIColor
    
    init(
        title: String,
        hint: String? = nil,
        color: UIColor,
        titleColor: UIColor
    ) {
        self.title = title
        self.hint = hint
        self.color = color
        self.titleColor = titleColor
        super.init(frame: .zero)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        setTitle(title, for: .normal)
        
        titleLabel?.adjustsFontForContentSizeCategory = true
        titleLabel?.font = UIFont.buttonTitle
        titleLabel?.numberOfLines = 0
        titleLabel?.lineBreakMode = .byWordWrapping
        backgroundColor = .black
        isAccessibilityElement = true
        accessibilityHint = hint
        
        contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        
        layer.cornerRadius = 6
        layer.borderWidth = 2
        layer.borderColor = UIColor.black.cgColor
        
        backgroundColor = color
        setTitleColor(titleColor, for: .normal)
    }
    
    
}
