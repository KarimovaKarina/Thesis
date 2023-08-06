import MoonPresentation
import UIKit

public final class TermsAndConditionsView: UIView {
    fileprivate let content = UILabel(frame: .zero)
    private let contentView = UIScrollView(frame: .zero)
    private let downloadedContent: String

    public init(downloadedContent: String) {
        self.downloadedContent = downloadedContent
        super.init(frame: .zero)
        setup()
        layout()
        setupHtml(with: downloadedContent)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        contentView.backgroundColor = .white
    }

    private func layout() {
        addSubview(contentView)
        contentView.constrain(.all, to: self)

        layoutContent()
    }

    private func layoutContent() {
        content.numberOfLines = 0
        content.textColor = .black
        contentView.addSubview(content)
        content.constrain(.all, to: contentView, constant: 20)
        content.constrain(.width, to: contentView, constant: -40)
    }

    func setupHtml(with htmlString: String) {
        let attr = NSMutableAttributedString(htmlString: htmlString)
        content.attributedText = attr?.adding(font: .systemFont(ofSize: 14))
    }
}
