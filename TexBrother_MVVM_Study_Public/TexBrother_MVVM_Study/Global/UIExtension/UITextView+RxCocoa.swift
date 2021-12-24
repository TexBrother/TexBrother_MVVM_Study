//
//  UITextView+RxCocoa.swift
//  Finut
//
//  Created by 노한솔 on 2021/09/02.
//

import Foundation
import UIKit

import RxCocoa
import RxSwift

extension UITextView {
    func setPlaceholder(placeholder: String , disposeBag: DisposeBag) {
      self.text = placeholder
        
      self.rx.didBeginEditing
        .bind {
          if self.text == placeholder {
            self.text = ""
          }
        }.disposed(by: disposeBag)
        
      self.rx.text
        .orEmpty.bind { text in
          if text == placeholder {
            self.textColor =  .gray
          }
          else {
            self.textColor = .blackBlack
          }
        }.disposed(by: disposeBag)
        
      self.rx.didEndEditing
        .bind {
          if self.text.isEmpty {
            self.textColor =  .gray
            self.text = placeholder
          }
        }.disposed(by: disposeBag)
    }
}
