//
//  UILabel+.swift
//  Finut
//
//  Created by 노한솔 on 2021/09/02.
//

import Foundation
import UIKit

// MARK: - UILabel Extension

extension UILabel {
    
    func setupLabel(text: String, color: UIColor, font: UIFont, align: NSTextAlignment? = .left) {
        self.font = font
        self.text = text
        self.textColor = color
        self.textAlignment = align ?? .left
    }
}
