//
//  SecondViewController.swift
//  TexBrother_MVVM_Study
//
//  Created by 노한솔 on 2022/02/01.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit
import Then

// MARK: - SecondViewController

final class SecondViewController: BaseViewController {
    
    // MARK: - Components
    
    private let emailTextField = UITextField().then {
        $0.font = UIFont.systemFont(ofSize: 14.adjusted, weight: .medium)
        $0.placeholder = "@와 .이 들어가야 함"
        $0.autocapitalizationType = .none
        $0.autocorrectionType = .no
        $0.textColor = .black
        $0.borderWidth = 1
        $0.borderColor = .blackGray1
        $0.setRounded(radius: 8.adjusted)
        $0.addLeftPadding()
    }
    
    private let passwordTextField = UITextField().then {
        $0.font = UIFont.systemFont(ofSize: 14.adjusted, weight: .medium)
        $0.placeholder = "8글자 이상의 영문, 숫자, 특수문자를 모두 포함"
        $0.autocapitalizationType = .none
        $0.autocorrectionType = .no
        $0.textColor = .black
        $0.borderWidth = 1
        $0.borderColor = .blackGray1
        $0.isSecureTextEntry = true
        $0.setRounded(radius: 8.adjusted)
        $0.addLeftPadding()
    }
    
    private let nicknameTextField = UITextField().then {
        $0.font = UIFont.systemFont(ofSize: 14.adjusted, weight: .medium)
        $0.placeholder = "2글자 이상"
        $0.autocapitalizationType = .none
        $0.autocorrectionType = .no
        $0.textColor = .black
        $0.borderWidth = 1
        $0.borderColor = .blackGray1
        $0.setRounded(radius: 8.adjusted)
        $0.addLeftPadding()
    }
    
    private let registerButton = UIButton().then {
        $0.setupButton(
            title: "등록",
            color: .systemBlue,
            font: .systemFont(ofSize: 14.adjusted, weight: .medium),
            backgroundColor: .clear,
            state: .normal,
            radius: 0
        )
    }
    
    private let privacyLabel = UILabel().then {
        $0.setupLabel(
            text: "개인정보처리방침 동의 [필수]",
            color: .black,
            font: .systemFont(ofSize: 14.adjusted, weight: .medium)
        )
    }
    
    private let privacyButton = UIButton().then {
        $0.setBackgroundImage(UIImage(systemName: "circle.dashed"), for: .normal)
        $0.setBackgroundImage(UIImage(systemName: "circle.dashed.inset.filled"), for: .selected)
    }
    
    private let promotionLabel = UILabel().then {
        $0.setupLabel(
            text: "프로모션 정보 제공 약관 동의 [선택]",
            color: .black,
            font: .systemFont(ofSize: 14.adjusted, weight: .medium)
        )
    }
    
    private let promotionButton = UIButton().then {
        $0.setBackgroundImage(UIImage(systemName: "circle.dashed"), for: .normal)
        $0.setBackgroundImage(UIImage(systemName: "circle.dashed.inset.filled"), for: .selected)
    }
    
    private let statusLabel = UILabel().then {
        $0.setupLabel(
            text: "",
            color: .black,
            font: .systemFont(ofSize: 16.adjusted, weight: .medium)
        )
        $0.numberOfLines = 3
    }
    
    private let nextButton = UIButton().then {
        $0.setupButton(
            title: "다음으로",
            color: .systemBlue,
            font: .systemFont(ofSize: 14.adjusted, weight: .medium),
            backgroundColor: .clear,
            state: .normal,
            radius: 0
        )
        $0.addTarget(self, action: #selector(touchupNextButton), for: .touchUpInside)
    }
    
    // MARK: - Variables
    
    private let viewModel = SecondViewModel()
    private let privacyAgreeSubject = BehaviorSubject<Bool>(value: false)
    private let promotionAgreeSubject = BehaviorSubject<Bool>(value: false)
    
    // MARK: - LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        layout()
    }
}

// MARK: - Extensions

extension SecondViewController {
    
    // MARK: - Layout Helpers
    
    private func layout() {
        view.adds(
            [
                emailTextField,
                passwordTextField,
                nicknameTextField,
                registerButton,
                privacyLabel,
                privacyButton,
                promotionLabel,
                promotionButton,
                statusLabel,
                nextButton
            ]
        )
        
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(60.adjusted)
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(40.adjusted)
            $0.height.equalTo(35.adjusted)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(self.emailTextField.snp.bottom).offset(20.adjusted)
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(40.adjusted)
            $0.height.equalTo(35.adjusted)
        }
        
        nicknameTextField.snp.makeConstraints {
            $0.top.equalTo(self.passwordTextField.snp.bottom).offset(20.adjusted)
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(40.adjusted)
            $0.height.equalTo(35.adjusted)
        }
        
        registerButton.snp.makeConstraints {
            $0.top.equalTo(self.nicknameTextField.snp.bottom).offset(30.adjusted)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(30.adjusted)
            $0.height.equalTo(25.adjusted)
        }
        
        privacyLabel.snp.makeConstraints {
            $0.top.equalTo(self.registerButton.snp.bottom).offset(20.adjusted)
            $0.leading.equalTo(self.emailTextField)
        }
        
        privacyButton.snp.makeConstraints {
            $0.centerY.equalTo(self.privacyLabel)
            $0.leading.equalTo(self.privacyLabel.snp.trailing).offset(8.adjusted)
            $0.width.height.equalTo(16.adjusted)
        }
        
        promotionLabel.snp.makeConstraints {
            $0.top.equalTo(self.privacyLabel.snp.bottom).offset(6.adjusted)
            $0.leading.equalTo(self.privacyLabel)
        }
        
        promotionButton.snp.makeConstraints {
            $0.centerY.equalTo(self.promotionLabel)
            $0.leading.equalTo(self.promotionLabel.snp.trailing).offset(8.adjusted)
            $0.width.height.equalTo(16.adjusted)
        }
        
        statusLabel.snp.makeConstraints {
            $0.top.equalTo(self.promotionLabel.snp.bottom).offset(40.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints {
            $0.top.equalTo(self.statusLabel.snp.bottom).offset(20.adjusted)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(50.adjusted)
            $0.height.equalTo(25.adjusted)
        }
    }
    
    // MARK: - General Helpers
    
    private func bind() {
        let input = SecondViewModel.Input(
            emailText: emailTextField.rx.text.orEmpty.asObservable(),
            passwordText: passwordTextField.rx.text.orEmpty.asObservable(),
            nickNameText: nicknameTextField.rx.text.orEmpty.asObservable(),
            registerBtnClicked: registerButton.rx.tap.asObservable(),
            privacyAgree: privacyAgreeSubject,
            promotionAgree: promotionAgreeSubject
        )
        
        let output = viewModel.transform(input: input)
        
        output.registerEnabled
            .bind(to: registerButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        registerButton.rx.tap.bind {
            output.registerResult.bind { [weak self] model in
                self?.statusLabel.text = """
                                아이디 : \(model.email)
                                비밀번호 : \(model.passWord)
                                닉네임: \(model.nickName)
                                """
            }.disposed(by: self.disposeBag)
        }.disposed(by: disposeBag)
        
        privacyButton.rx.tap.map{ [weak self] in
            self?.privacyButton.isSelected.toggle()
            return self?.privacyButton.isSelected ?? false
        }
        .bind(to: privacyAgreeSubject)
        .disposed(by: disposeBag)
        
        promotionButton.rx.tap.map{ [weak self] in
            self?.promotionButton.isSelected.toggle()
            return self?.promotionButton.isSelected ?? false
        }
        .bind(to: promotionAgreeSubject)
        .disposed(by: disposeBag)
    }
    
    // MARK: - Action Helpers
    
    @objc
    private func touchupNextButton() {
        let secondVC = ThirdViewController()
        navigationController?.pushViewController(secondVC, animated: true)
    }
}
