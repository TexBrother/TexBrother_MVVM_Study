//
//  SecondViewModel.swift
//  TexBrother_MVVM_Study
//
//  Created by 노한솔 on 2022/02/01.
//

import Foundation
import RxSwift
import RxCocoa

// MARK: - SecondViewModel

final class SecondViewModel {
  struct Input {
    let emailText: Observable<String>
    let passwordText: Observable<String>
    let nickNameText: Observable<String>
    let registerBtnClicked: Observable<Void>
    let privacyAgree: Observable<Bool>
    let promotionAgree: Observable<Bool>
  }
  struct Output {
    let registerResult: Observable<RegisterModel>
    let registerEnabled: Observable<Bool>
  }
}
extension SecondViewModel {

  func transform (input: Input) -> Output {
      let registerModel = Observable.combineLatest(input.emailText,
                                                   input.passwordText,
                                                   input.nickNameText,
                                                   input.privacyAgree,
                                                   input.promotionAgree)
        .map {email, password, nickname, privacy, promotion -> RegisterModel in
          let temp = RegisterModel(email: email,
                                   passWord: password,
                                   nickName: nickname,
                                   privacy: privacy,
                                   promotion: promotion)
          return temp
        }
      
      // TODO - validate using regex
      // HINT - CombineLatest, flatMapLatest
//
//      let enabled =
//      let register =
//      return .init(registerResult: register, registerEnabled: enabled)

  }
}
