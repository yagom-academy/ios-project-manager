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
    func firstButtonDidTap()
    func secondButtonDidTap()
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
    
    private let stateReplayRelay = ReplayRelay<State>.create(bufferSize: 1)
    
    func setbuttonTitle(state: State) {
        stateReplayRelay.accept(state)
    }
    
    var buttonTitle: Observable<(String, String)> {
        stateReplayRelay
            .take(1)
            .withUnretained(self)
            .map { (self, state) in
                self.useCase.changeToTitle(at: state)
            }
    }
    
    func firstButtonDidTap() {
        actions?.dismiss()
    }
    
    func secondButtonDidTap() {
        actions?.dismiss()
    }
}
