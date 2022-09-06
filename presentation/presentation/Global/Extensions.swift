//
//  Extensions.swift
//  presentation
//
//  Created by Nihad Ismayilov on 05.09.22.
//

import Foundation
import UIKit

extension UILabel {
    func getFont(name: String, ofSize: Int) {
        let customFont = UIFont(name: name, size: CGFloat(ofSize))
        self.font = UIFontMetrics.default.scaledFont(for: customFont ?? UIFont.systemFont(ofSize: UIFont.labelFontSize))
        self.adjustsFontForContentSizeCategory = true
    }
}
