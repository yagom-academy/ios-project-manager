//
//  TodoMoveViewModel.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/14.
//

import Foundation
import RxSwift
import RxCocoa

struct TodoMoveViewModelActions {
    let dismiss: () -> Void
    let showErrorAlert: (_ message: String) -> Void
}

protocol TodoMoveViewModelInput {
    func firstButtonDidTap()
    func secondButtonDidTap()
}

protocol TodoMoveViewModelOutput {
    var buttonTitle: Observable<(String, String)> { get }
}

protocol TodoMoveViewModel: TodoMoveViewModelInput, TodoMoveViewModelOutput {}

final class DefaultTodoMoveViewModel {
    private let useCase: TodoListUseCase
    private let actions: TodoMoveViewModelActions?
    private let item: TodoModel
    private let bag = DisposeBag()
    
    init(useCase: TodoListUseCase, actions: TodoMoveViewModelActions, item: TodoModel) {
        self.useCase = useCase
        self.actions = actions
        self.item = item
    }
    
    private func changeToTitle(at state: State) -> String {
        switch state {
        case .todo:
            return "Move to TODO"
        case .doing:
            return "Move to DOING"
        case .done:
            return "Move to DONE"
        }
    }
}

extension DefaultTodoMoveViewModel: TodoMoveViewModel {
    
    //MARK: - Output
    var buttonTitle: Observable<(String, String)> {
        let (firstButtonType, secondButtonType) = useCase.moveState(from: item.state)
        let firstButtonTitle = changeToTitle(at: firstButtonType)
        let secondButtonTitle = changeToTitle(at: secondButtonType)
        
        return Observable.just((firstButtonTitle, secondButtonTitle))
    }
    
    //MARK: - Input
    func firstButtonDidTap() {
        var newItem = item
        newItem.state = useCase.moveState(from: item.state).first
        useCase.saveItem(to: newItem)
            .subscribe { [weak self] in
                self?.actions?.dismiss()
            } onError: { [weak self] _ in
                self?.actions?.dismiss()
                self?.actions?.showErrorAlert("수정 오류 발생")
            }.disposed(by: bag)
    }
    
    func secondButtonDidTap() {
        var newItem = item
        newItem.state = useCase.moveState(from: item.state).second
        useCase.saveItem(to: newItem)
            .subscribe { [weak self] in
                self?.actions?.dismiss()
            } onError: { [weak self] _ in
                self?.actions?.dismiss()
                self?.actions?.showErrorAlert("수정 오류 발생")
            }.disposed(by: bag)
    }
}
