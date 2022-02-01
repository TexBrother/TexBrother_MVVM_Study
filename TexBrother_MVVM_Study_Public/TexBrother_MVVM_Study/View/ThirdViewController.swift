//
//  ThirdViewController.swift
//  TexBrother_MVVM_Study
//
//  Created by hansol on 2022/02/02.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit
import Then

// MARK: - ThirdViewController

final class ThirdViewController: BaseViewController {
    
    // MARK: - Lazy Components
    
    private lazy var emailTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain).then {
            $0.backgroundColor = .clear
            $0.separatorStyle = .none
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.estimatedRowHeight = 80
            $0.rowHeight = UITableView.automaticDimension
        }
        return tableView
    }()
    
    // MARK: - Components
    
    private let emailTextField = UITextField().then {
        $0.keyboardType = .emailAddress
        $0.autocorrectionType = .no
        $0.autocapitalizationType = .none
        $0.font = .systemFont(ofSize: 14.adjusted, weight: .regular)
        $0.textColor = .blackBlack
        $0.placeholder = "이메일을 입력해주세요"
        $0.borderColor = .blackGray2
        $0.borderWidth = 1
        $0.setRounded(radius: 8.adjusted)
        $0.addLeftPadding()
    }
    
    private let addButton = UIButton().then {
        $0.setupButton(
            title: "추가",
            color: .systemBlue,
            font: .systemFont(ofSize: 14.adjusted, weight: .medium),
            backgroundColor: .clear,
            state: .normal,
            radius: 0
        )
    }
    
    private let deleteButton = UIButton().then {
        $0.setupButton(
            title: "모두 삭제",
            color: .systemBlue,
            font: .systemFont(ofSize: 14.adjusted, weight: .medium),
            backgroundColor: .clear,
            state: .normal,
            radius: 0
        )
    }
    
    // MARK: - Variables
    
    private let loadViewTrigger = PublishSubject<Void>()
    private let viewModel = ThirdViewModel()
    
    // MARK: - LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        register()
        layout()
        bind()
    }
}

// MARK: - Extensions

extension ThirdViewController {
    
    // MARK: - Layout Helpers
    
    private func layout() {
        view.adds(
            [
                emailTableView,
                emailTextField,
                addButton,
                deleteButton
            ]
        )
        
        emailTableView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(self.emailTableView.snp.bottom).offset(10.adjusted)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(20.adjusted)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-56.adjusted)
            $0.height.equalTo(30.adjusted)
        }
        
        addButton.snp.makeConstraints {
            $0.centerY.equalTo(self.emailTextField)
            $0.leading.equalTo(self.emailTextField.snp.trailing).offset(6.adjusted)
            $0.width.equalTo(30.adjusted)
            $0.height.equalTo(24.adjusted)
        }
        
        deleteButton.snp.makeConstraints {
            $0.top.equalTo(self.emailTextField.snp.bottom).offset(20.adjusted)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(60.adjusted)
            $0.height.equalTo(24.adjusted)
            $0.bottom.lessThanOrEqualTo(self.view.safeAreaLayoutGuide).offset(-40.adjusted)
        }
    }
    
    private func relayout(height: CGFloat) {
        emailTableView.snp.remakeConstraints {
            $0.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(height)
        }
    }
    
    // MARK: - General Helpers
    
    private func register() {
        emailTableView.register(EmailTableViewCell.self, forCellReuseIdentifier: EmailTableViewCell.identifier)
    }
    
    private func bind() {
        let deleteItem = Observable.zip(
            emailTableView.rx.itemSelected.asObservable(),
            emailTableView.rx.modelSelected(EmailModel.self).asObservable()
        )
        
        let input = ThirdViewModel.Input(
            loadView: loadViewTrigger,
            newContent: emailTextField.rx.text.orEmpty.asObservable(),
            addContent: addButton.rx.tap.asObservable(),
            deleteContent: deleteItem,
            deleteAll: deleteButton.rx.tap.asObservable()
        )
        
        let output = viewModel.transform(input: input)
        output.tableViewItems
            .bind(to: emailTableView.rx.items(
                cellIdentifier: EmailTableViewCell.identifier,
                cellType: EmailTableViewCell.self)) {row, data, cell in
                    cell.bind(model: data)
                }.disposed(by: disposeBag)
        
        emailTableView.rx.observeWeakly(CGSize.self, "contentSize")
            .compactMap{$0?.height}
            .distinctUntilChanged()
            .bind {[weak self] height in
                self?.relayout(height: height)
            }.disposed(by: disposeBag)
        
        viewModel.state.currentItems.bind {
            print($0)
        }.disposed(by: disposeBag)
        
        loadViewTrigger.onNext(())
    }
}
