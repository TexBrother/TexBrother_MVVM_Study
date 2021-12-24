//
//  UITabBar+.swift
//  Finut
//
//  Created by hansol on 2021/12/20.
//

import UIKit

extension UITabBar {
    
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        super.sizeThatFits(size)
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 150
        return sizeThatFits
    }
}
