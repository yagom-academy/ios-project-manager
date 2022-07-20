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
    
    private func changeItemState(to state: State) {
        var newItem = item
        newItem.state = state
        useCase.saveItem(to: newItem)
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
        let newState = useCase.moveState(from: item.state).first
        changeItemState(to: newState)
        actions?.dismiss()
    }
    
    func secondButtonDidTap() {
        let newState = useCase.moveState(from: item.state).second
        changeItemState(to: newState)
        actions?.dismiss()
    }
}
