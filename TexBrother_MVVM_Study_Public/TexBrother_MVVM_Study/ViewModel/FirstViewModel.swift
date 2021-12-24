//
//  FirstViewModel.swift
//  TexBrother_MVVM_Study
//
//  Created by hansol on 2021/12/24.
//

import RxSwift
import RxCocoa
import SnapKit
import Then

// MARK: - FirstViewModel

final class FirstViewModel {
    
    struct Input {
        let buttonClicked: Observable<Int>
        let textFieldString: Observable<String>
    }
    
    struct Output {
        let selectedButton : Observable<ButtonModel>
        let textCount: Observable<Int>
    }
}

// MARK: - Extensions

extension FirstViewModel {
//    TODO
//    func transform (input : Input) -> Output {
//    }
}
