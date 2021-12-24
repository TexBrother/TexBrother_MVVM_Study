////
////  UIImageView+.swift
////  Finut
////
////  Created by 노한솔 on 2021/09/02.
////
//
//import Foundation
//import UIKit
//
//import Kingfisher
//
//// MARK: - UIImageView Extension
//
//extension UIImageView {
//  
//  public func imageFromUrl(_ urlString: String?, defaultImageName: String?) {
//    
//    let tempURL: String?
//    
//    if urlString == nil {
//      tempURL = ""
//    } else  {
//      tempURL = urlString
//    }
//    
//    if let url = tempURL,
//       let defaultURL: String = defaultImageName {
//        
//      if url.isEmpty {
//        self.image = UIImage(named: defaultURL)
//      } else {
//        self.kf.setImage(
//            with: URL(string: url),
//            options: [.transition(ImageTransition.fade(0.5))])
//      }
//    }
//  }
//}
