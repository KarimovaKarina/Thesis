import Combine
import Foundation
import UIKit

internal final class TappableTextView: UIView {
    public var didTap: AnyPublisher<String, Never> {
        _didTap.eraseToAnyPublisher()
    }

    private let fullText: String
    private let tappableStrings: [String: String]
    private let textView = UITextView()
    private let _didTap = PassthroughSubject<String, Never>()

    public init(tappableText: [String], fullText: String) {
        self.fullText = fullText
        self.tappableStrings = tappableText.asTappableStrings
        super.init(frame: .zero)

        setupTextView()
        setAttributedText()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupTextView() {
        addSubview(textView)
        textView.constrain(.all, to: self)

        textView.delegate = self
        textView.setContentHuggingPriority(.required, for: .vertical)
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.isUserInteractionEnabled = true
        textView.textAlignment = .left
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = .zero
        textView.backgroundColor = .clear
    }

    private func setAttributedText() {
        let tappableTextAttributes: [NSAttributedString.Key: Any]
        let regularTextAttributes: [NSAttributedString.Key: Any]
        
        let style = NSMutableParagraphStyle()
        style.lineHeightMultiple = 1


        tappableTextAttributes = [
                .font: UIFont.bodyS,
                .foregroundColor: UIColor.red,
                .paragraphStyle: style
            ]
        
        regularTextAttributes = [
                .font: UIFont.bodyS,
                .foregroundColor: UIColor.darkText,
                .paragraphStyle: style
        ]

        let fullText = NSMutableAttributedString(
            string: fullText,
            attributes: regularTextAttributes
        )

        for (id, highlightedText) in tappableStrings {
            let tappableText = NSMutableAttributedString(string: highlightedText)
            tappableText.addAttribute(.link, value: id, range: NSRange(0 ..< tappableText.length))
            tappableText.addAttributes(tappableTextAttributes, range: NSRange(0 ..< tappableText.length))
            let range = (fullText.string as NSString).range(of: highlightedText)
            fullText.replaceCharacters(in: range, with: tappableText)
        }

        textView.linkTextAttributes = tappableTextAttributes
        textView.attributedText = fullText
    }
}

extension TappableTextView: UITextViewDelegate {
    public func textView(
        _: UITextView,
        shouldInteractWith url: URL,
        in _: NSRange,
        interaction _: UITextItemInteraction
    ) -> Bool {
        guard let key = tappableStrings.keys.first(where: { $0 == url.absoluteString }) else {
            return false
        }
        tappableStrings[key].map { _didTap.send($0) }
        return true
    }
}

private extension Array where Element == String {
    var asTappableStrings: [String: String] {
        Dictionary(uniqueKeysWithValues: map { (UUID().uuidString, $0) })
    }
}
