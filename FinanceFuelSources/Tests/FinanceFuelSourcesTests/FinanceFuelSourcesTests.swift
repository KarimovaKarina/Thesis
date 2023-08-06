import XCTest
@testable import FinanceFuelSources
import OAT

final class FinanceFuelSourcesTests: XCTestCase {
    func testExample() throws {        
        let button = AccessibleButton(
            title: "Ok",
            hint: "Saves your edits.",
            color: .white,
            titleColor: .gray
        )
        checkAccessibility(button)
    }
    
    func testImageView() throws {
        let image = UIImageView()
//        checkAccessibility(image, with: .init(excluding: [.images], recursiveChecking: false))
//        image.isAccessibilityElement = true
//        image.accessibilityLabel = "App icon"
//        checkAccessibility(image)
    }
    
    func testTextField() throws {
        let image = UITextView()
        image.textContentType = .telephoneNumber
        image.keyboardType = .namePhonePad
        checkAccessibility(image)
    }
    
    func testLabel() throws {
        let label = UILabel()
        let fullText = "da privet and tappable"
        let tappableStrings = ["privet", "tappable"].asTappableStrings
        let styleRegular = NSMutableParagraphStyle()
        styleRegular.lineHeightMultiple = 1.5
        
        let styleTappable = NSMutableParagraphStyle()
        styleTappable.lineHeightMultiple = 1.5
        let tappableTextAttributes: [NSAttributedString.Key: Any]
        let regularTextAttributes: [NSAttributedString.Key: Any]
        
        
        tappableTextAttributes = [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
                NSAttributedString.Key.foregroundColor: UIColor.red,
                .paragraphStyle: styleTappable
            ]
        
        regularTextAttributes = [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12),
                NSAttributedString.Key.foregroundColor: UIColor.black,
                .paragraphStyle: styleRegular
            ]

        let fullTextAttr = NSMutableAttributedString(
            string: fullText,
            attributes: regularTextAttributes
        )
        

        for (id, highlightedText) in tappableStrings {
            let tappableText = NSMutableAttributedString(string: highlightedText)
            tappableText.addAttribute(.link, value: id, range: NSRange(0 ..< tappableText.length))
            tappableText.addAttributes(tappableTextAttributes, range: NSRange(0 ..< tappableText.length))
            let range = (fullTextAttr.string as NSString).range(of: highlightedText)
            fullTextAttr.replaceCharacters(in: range, with: tappableText)
        }
        label.attributedText = fullTextAttr
        
        checkAccessibility(label)
    }
    
    func testHierarchy() {
        let view = LoginView(mainLabelTitle: "Ola", buttonTitle: "Ola-la")
        checkAccessibility(view)
    }
    
    func testButton() {
        let button = UIButton()
        button.setTitle("", for: .normal)
        checkAccessibility(button)
    }
}

private extension Array where Element == String {
    var asTappableStrings: [String: String] {
        Dictionary(uniqueKeysWithValues: map { (UUID().uuidString, $0) })
    }
}
