//
//  FirstViewController.swift
//  TexBrother_MVVM_Study
//
//  Created by hansol on 2021/12/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

// MARK: - FirstViewController

final class FirstViewController: BaseViewController {

    // MARK: - Components
    
    private let firstButton = UIButton().then {
        $0.setupButton(
            title: "1번",
            color: .blackGray1,
            font: .systemFont(ofSize: 14.adjusted),
            backgroundColor: .clear,
            state: .normal,
            radius: 0
        )
    }
    
    private let secondButton = UIButton().then {
        $0.setupButton(
            title: "2번",
            color: .blackGray1,
            font: .systemFont(ofSize: 14.adjusted),
            backgroundColor: .clear,
            state: .normal,
            radius: 0
        )
    }
    
    private let thirdButton = UIButton().then {
        $0.setupButton(
            title: "3번",
            color: .blackGray1,
            font: .systemFont(ofSize: 14.adjusted),
            backgroundColor: .clear,
            state: .normal,
            radius: 0
        )
    }
    
    private let buttonLabel = UILabel().then {
        $0.setupLabel(text: "버튼을 눌러주세요.", color: .blackGray1, font: .systemFont(ofSize: 20.adjusted))
    }
    
    private let countTextField = UITextField().then {
        $0.font = .systemFont(ofSize: 14.adjusted)
        $0.textColor = .blackGray1
        $0.borderWidth = 1
        $0.borderColor = .blackGray1
        $0.setRounded(radius: 8.adjusted)
    }
    
    private let countLabel = UILabel().then {
        $0.setupLabel(text: "0", color: .blackGray1, font: .systemFont(ofSize: 14.adjusted))
    }
    
    // MARK: - Variables
    
    private let viewModel = FirstViewModel()
    private let buttonClickSubject = PublishSubject<Int>()
    private let textSubject = PublishSubject<String>()
    
    // MARK: - LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        bind()
    }
}

// MARK: - Extensions

extension FirstViewController {
    
    // MARK: - Layout Helpers
    
    private func layout() {
        view.adds(
            [
                firstButton,
                secondButton,
                thirdButton,
                buttonLabel,
                countTextField,
                countLabel
            ]
        )
        
        secondButton.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(200.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        firstButton.snp.makeConstraints {
            $0.top.equalTo(self.secondButton)
            $0.trailing.equalTo(self.secondButton.snp.leading).offset(-100.adjusted)
        }
        
        thirdButton.snp.makeConstraints {
            $0.top.equalTo(self.secondButton)
            $0.leading.equalTo(self.secondButton.snp.trailing).offset(100.adjusted)
        }
        
        buttonLabel.snp.makeConstraints {
            $0.top.equalTo(self.secondButton.snp.bottom).offset(50.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        countTextField.snp.makeConstraints {
            $0.top.equalTo(self.buttonLabel.snp.bottom).offset(100.adjusted)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(20.adjusted)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-50.adjusted)
            $0.height.equalTo(40.adjusted)
        }
        
        countLabel.snp.makeConstraints {
            $0.centerY.equalTo(self.countTextField)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-20.adjusted)
        }
    }
    
    // MARK: - General Helpers
    
    private func bind() {
        let input = FirstViewModel.Input(
            buttonClicked: buttonClickSubject,
            textFieldString: textSubject
        )
        // TODO
    }
}
