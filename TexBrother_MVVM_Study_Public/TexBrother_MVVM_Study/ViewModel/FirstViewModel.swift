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
    func transform (input : Input) -> Output {
      
      let temp : Observable<[ButtonModel]> =
        Observable.just(
            [
                .init(buttonNumber: 1, buttonInfo: "첫 번째 버튼입니다."),
                .init(buttonNumber: 2, buttonInfo: "두 번째 버튼입니다."),
                .init(buttonNumber: 3, buttonInfo: "세 번째 버튼입니다.")
            ]
        )
      
      let selectedItem = input.buttonClicked
        .flatMapLatest{ idx -> Observable<ButtonModel> in
        let selected = temp.map {
          $0.first(where: {$0.buttonNumber == idx})!
        }
        return selected
      }
      
      let count: Observable<Int> = input.textFieldString.map {
        $0.count
      }
      
      return Output(selectedButton: selectedItem, textCount: count)
    }
}
