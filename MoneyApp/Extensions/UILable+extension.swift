//
//  UILable+extension.swift
//  MoneyApp
//
//  Created by Arman on 31.12.2021.
//

import UIKit

extension UILabel {
    convenience init(text: String, font: UIFont? = .laoSangamMN20()) {
        self.init()
        
        self.text = text
        self.font = font
    }
}
