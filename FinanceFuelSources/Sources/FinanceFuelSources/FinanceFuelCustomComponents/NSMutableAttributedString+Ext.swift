import Foundation
import UIKit

public extension NSMutableAttributedString {
    convenience init?(htmlString html: String) {
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        guard
            let data = html.data(using: .utf8, allowLossyConversion: true),
            let attr = try? NSMutableAttributedString(
                data: data,
                options: options,
                documentAttributes: nil
            )
        else {
            return nil
        }
        
        self.init(attributedString: attr)
    }
    
    func adding(font: UIFont) -> NSMutableAttributedString? {
        enumerateAttribute(
            NSAttributedString.Key.font,
            in: NSRange(location: 0, length: length),
            options: .longestEffectiveRangeNotRequired
        ) { value, range, _ in
            let f1 = value as! UIFont
            if let f3 = applyFontFamily(to: f1, familyOf: font) {
                self.addAttribute(NSAttributedString.Key.font, value: f3, range: range)
            }
        }
        return self
    }

    private func applyFontFamily(to f1: UIFont, familyOf: UIFont) -> UIFont? {
        let family = familyOf.familyName
        let traits = familyOf.fontDescriptor.symbolicTraits
        let fd = f1.fontDescriptor.withFamily(family)
        guard let descriptor = fd.withSymbolicTraits(traits) else { return nil }
        return UIFont(descriptor: descriptor, size: 0)
    }
}
