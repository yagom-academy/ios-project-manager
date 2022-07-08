//
//  DefaultTodoDetailViewModel.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/06.
//

import Foundation

protocol TodoDetailViewModelInput {
    func closeButtonDidTap()
    func doneButtonDidTap(title: String, content: String, deadLine: Date)
}
protocol TodoDetailViewModelOutput {}
protocol TodoDetailViewModel: TodoDetailViewModelInput, TodoDetailViewModelOutput {}

struct TodoDetailActions {
    let dismiss: () -> Void
}

final class DefaultTodoDetailViewModel: TodoDetailViewModel {

    private let actions: TodoDetailActions
    private let useCase: UseCase
    
    init(actions: TodoDetailActions, useCase: UseCase) {
        self.actions = actions
        self.useCase = useCase
    }
}

extension DefaultTodoDetailViewModel {
    
    // MARK: - Input
    
    func closeButtonDidTap() {
        actions.dismiss()
    }
    
    func doneButtonDidTap(title: String, content: String, deadLine: Date) {
        useCase.create(TodoListModel(title: title, content: content, deadLine: deadLine))
        actions.dismiss()
    }
}
