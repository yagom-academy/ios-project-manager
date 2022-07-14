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
    func setbuttonTitle(state: State)
}

protocol TodoMoveViewModelOutput {
    var buttonTitle: Observable<(String, String)> { get }
}

protocol TodoMoveViewModel: TodoMoveViewModelInput, TodoMoveViewModelOutput {}

final class DefaultTodoMoveViewModel: TodoMoveViewModel {
    private let useCase: UseCase
    
    private var actions: TodoMoveViewModelActions?
    
    init(useCase: UseCase, actions: TodoMoveViewModelActions) {
        self.useCase = useCase
        self.actions = actions
    }
    
    private let statePublishRelay: PublishRelay<State> = PublishRelay()
    
    func setbuttonTitle(state: State) {
        statePublishRelay.accept(state)
    }
    
    var buttonTitle: Observable<(String, String)> {
        statePublishRelay
            .take(1)
            .withUnretained(self)
            .map { (self, state) in
                self.xxx(state: state)
            }
            .debug()
    }
    
}

extension DefaultTodoMoveViewModel {
    func xxx(state: State) -> (String, String) {
        switch state {
        case .todo:
            return ("Move to DOING", "Move to DONE")
        case .doing:
            return ("Move to TODO", "Move to DONE")
        case .done:
            return ("Move to TODO", "Move to DOING")
        }
    }
}
