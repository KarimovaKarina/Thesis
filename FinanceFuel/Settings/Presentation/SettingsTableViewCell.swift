import UIKit

internal class SettingsTableViewCell: UITableViewCell {
    private let titleLabel = UILabel()
    private let arrowImageView = UIImageView(image: UIImage(systemName: "chevron.forward"))
    private let containerView = UIView()
    
    override required init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        isAccessibilityElement = true
        accessibilityTraits = .button
        titleLabel.font = .buttonTitle
    }
    
    private func layout() {
        contentView.addSubview(containerView)
        containerView.constrain(.all, to: contentView, constant: .edges)
        
        containerView.addSubview(arrowImageView)
        arrowImageView.constrain(.top, to: containerView)
        arrowImageView.constrain(.right, to: containerView)
        arrowImageView.constrain(size: CGSize(width: 15, height: 25))
        
        containerView.addSubview(titleLabel)
        titleLabel.constrain(.all(except: .right), to: containerView)
        titleLabel.constrain(.right, to: arrowImageView, edge: .left, constant: -.edges)
    }
    
    func update(text: String) {
        titleLabel.text = text
        titleLabel.numberOfLines = 0
    }
}
