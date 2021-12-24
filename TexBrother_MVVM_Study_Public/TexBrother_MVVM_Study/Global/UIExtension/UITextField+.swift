//
//  UITextField+.swift
//  Finut
//
//  Created by 노한솔 on 2021/09/02.
//

import Foundation
import UIKit

// MARK: - UITextField Extension

extension UITextField {
    
    func addLeftPadding(as offset: CGFloat? = 10) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: offset ?? 10, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
    
    class func textFieldWithInsets(insets: UIEdgeInsets) -> UITextField {
        return FourInsetTextField(insets: insets)
    }
    
    func configureTextField(textColor: UIColor, font: UIFont, placeholder: String? = "") {
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        self.textColor = textColor
        self.font = font
        self.placeholder = placeholder ?? ""
    }
    
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.3
        animation.values = [-5.0, 5.0, -5.0, 5.0 ,-2.0, 2.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}

// MARK: - FourInsetTextField
class FourInsetTextField: UITextField {
    var insets: UIEdgeInsets
    
    init(insets: UIEdgeInsets) {
        self.insets = insets
        super.init(frame: .zero)
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("not intended for use from a NIB")
    }
    
    // placeholder position
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return super.textRect(forBounds: bounds.inset(by: insets))
    }
    
    // text position
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return super.editingRect(forBounds: bounds.inset(by: insets))
    } 
    
}

