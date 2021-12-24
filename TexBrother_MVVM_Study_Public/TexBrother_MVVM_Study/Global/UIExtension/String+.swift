//
//  String+.swift
//  Finut
//
//  Created by hansol on 2021/10/29.
//

import Foundation
import UIKit

extension String {
    
    func stringToDateWithTime() -> Date {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        print(self)
        
         return formatter.date(from: self)!
    }
    
    func stringToDate() -> Date {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy-MM-dd"
        
        return formatter.date(from: self)!
    }
}
