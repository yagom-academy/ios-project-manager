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
}

protocol TodoMoveViewModelInput {
    func setbuttonsTitle(state: State)
    func firstButtonDidTap(item: TodoModel)
    func secondButtonDidTap(item: TodoModel)
}

protocol TodoMoveViewModelOutput {
    var buttonTitle: Observable<(String, String)> { get }
}

protocol TodoMoveViewModel: TodoMoveViewModelInput, TodoMoveViewModelOutput {}

final class DefaultTodoMoveViewModel {
    private let useCase: TodoListUseCase
    
    private var actions: TodoMoveViewModelActions?
    
    init(useCase: TodoListUseCase, actions: TodoMoveViewModelActions) {
        self.useCase = useCase
        self.actions = actions
    }
    
    private let stateReplayRelay = ReplayRelay<State>.create(bufferSize: 1)
}

extension DefaultTodoMoveViewModel: TodoMoveViewModel {
    
    //MARK: - Output
    var buttonTitle: Observable<(String, String)> {
        stateReplayRelay
            .take(1)
            .withUnretained(self)
            .map { (self, state) in
                self.useCase.changeToTitle(at: state)
            }
    }
    
    //MARK: - Input
    func setbuttonsTitle(state: State) {
        stateReplayRelay.accept(state)
    }
    
    func firstButtonDidTap(item: TodoModel) {
        var newItem = item
        newItem.state = useCase.moveState(from: item.state).first
        useCase.saveItem(to: newItem)
        actions?.dismiss()
    }
    
    func secondButtonDidTap(item: TodoModel) {
        var newItem = item
        newItem.state = useCase.moveState(from: item.state).second
        useCase.saveItem(to: newItem)
        actions?.dismiss()
    }
}
