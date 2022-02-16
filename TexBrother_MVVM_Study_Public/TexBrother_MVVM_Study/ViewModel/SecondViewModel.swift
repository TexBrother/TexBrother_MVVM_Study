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
      .map{ email, passwd, nickname, privacy, promotion -> RegisterModel in
        let temp = RegisterModel(email: email,
                                 passWord: passwd,
                                 nickName: nickname,
                                 privacy: privacy,
                                 promotion: promotion)
        print(temp)
        return temp
      }
    let enabled = Observable.combineLatest(input.emailText,
                                           input.passwordText,
                                           input.nickNameText,
                                           input.privacyAgree)
      .map{email, passwd, nickname, privacy -> Bool in
        return email.validate(with: .email) && passwd.validate(with: .password) && nickname.validate(with: .nickname) && privacy
      }
    
    let emailEnabled = input.emailText.map{$0.validate(with: .email)}
    let passwordEnabeld = input.passwordText.map{$0.validate(with: .password)}
    let nickNameEnabeld = input.nickNameText.map{$0.validate(with: .nickname)}
    let registerEnabled = Observable.combineLatest(emailEnabled, passwordEnabeld, nickNameEnabeld)
      .map{$0.0 && $0.1 && $0.2}

    let register = input.registerBtnClicked
      .flatMapLatest{
        return registerModel
      }
      
    return .init(registerResult: register, registerEnabled: enabled)
  }
}
