//
//  Font+Ext.swift
//  FinanceFuel
//
//  Created by Karina Karimova on 22.02.2023.
//

import UIKit

extension UIFont {
    static var buttonTitle: UIFont {
        UIFont.preferredFont(forTextStyle: .title3)
    }
    
    static var bodyXS: UIFont {
        UIFont.preferredFont(forTextStyle: .caption2)
    }
    
    static var bodyS: UIFont {
        UIFont.preferredFont(forTextStyle: .footnote)
    }
}
