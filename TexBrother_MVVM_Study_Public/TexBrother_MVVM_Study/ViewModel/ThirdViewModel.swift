//
//  ThirdViewModel.swift
//  TexBrother_MVVM_Study
//
//  Created by hansol on 2022/02/02.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit
import Then

// MARK: - ThirdViewModel

final class ThirdViewModel {
    struct Input {
        let loadView: Observable<Void>
        let newContent: Observable<String>
        let addContent: Observable<Void>
        let deleteContent: Observable<(IndexPath, EmailModel)>
        
        let deleteAll: Observable<Void>
    }
    struct Output {
        let tableViewItems: Observable<[EmailModel]>
    }
    struct State {
        var currentItems = BehaviorSubject<[EmailModel]>(value: [])
    }
    var state = State()
}

extension ThirdViewModel {
    func transform(input : Input) -> Output {
        weak var `self` = self
        
        let addItem = input.addContent
            .withLatestFrom(input.newContent)
            .map{EmailModel(content: $0, textColor: .brown)}
        
        let items = input.loadView
            .withLatestFrom(self?.state.currentItems ?? .empty())
            .flatMapLatest{ usecase -> Observable<[EmailModel]> in
                return self?.addTableView(
                    addItem: addItem,
                    deleteItem: input.deleteContent,
                    deleteAll: input.deleteAll,
                    usecase: usecase
                ) ?? .empty()
            }
        return .init(tableViewItems: items)
    }
    
    private func addTableView (
        // action
        addItem : Observable<EmailModel>,
        deleteItem: Observable<(IndexPath, EmailModel)>,
        deleteAll: Observable<Void>,
        // data
        usecase : [EmailModel]) -> Observable<[EmailModel]> {
            weak var `self` = self
            enum Action {
                case add(EmailModel)
                case delete(IndexPath, EmailModel)
                case deleteAll(Void)
            }
            return Observable.merge(
                addItem.map(Action.add),
                deleteItem.map(Action.delete),
                deleteAll.map(Action.deleteAll)
            )
                .scan(into:usecase) { state, action in
                    switch action {
                    case .add(let model):
                        state.append(model)
                        self?.state.currentItems.onNext(state)
                    case .delete(let indexpath, let model):
                        if state[indexpath.row].content == model.content {
                            state.remove(at: indexpath.row)
                        }
                    case .deleteAll:
                        state = []
                    }
                }.startWith(usecase)
        }
}
