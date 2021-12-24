//
//  ViewModel.swift
//  Finut
//
//  Created by 노한솔 on 2021/09/02.
//

import Foundation
import RxSwift

// MARK: - ViewModelType

protocol ViewModelType {
    
  associatedtype Input
  associatedtype Output
    
  func transform(input: Input) -> Output
}
