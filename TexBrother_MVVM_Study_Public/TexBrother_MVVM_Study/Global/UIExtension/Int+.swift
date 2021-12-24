//
//  Int+.swift
//  Finut
//
//  Created by 노한솔 on 2021/09/03.
//

import Foundation
import UIKit

// MARK: - Int Extension

extension Int {
    var adjusted: CGFloat {
        let ratio: CGFloat = UIScreen.main.bounds.width / 375
        return CGFloat(self) * ratio
    }
}
