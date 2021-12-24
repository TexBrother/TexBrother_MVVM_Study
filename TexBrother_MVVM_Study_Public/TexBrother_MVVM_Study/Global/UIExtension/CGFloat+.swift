//
//  CGFloat+.swift
//  Finut
//
//  Created by 노한솔 on 2021/09/01.
//

import Foundation
import UIKit

// MARK: - CGFloat Extensions

extension CGFloat {
    var adjusted: CGFloat {
        let ratio: CGFloat = UIScreen.main.bounds.width / 375
        return self * ratio
    }
}
