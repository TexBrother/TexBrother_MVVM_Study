//
//  Double.swift
//  Finut
//
//  Created by 노한솔 on 2021/09/01.
//

import Foundation
import UIKit

// MARK: - Double Extension

extension Double {
    
    var adjusted: CGFloat {
        let ratio: CGFloat = CGFloat(UIScreen.main.bounds.width / 375)
        return CGFloat(self) * ratio
    }
}
