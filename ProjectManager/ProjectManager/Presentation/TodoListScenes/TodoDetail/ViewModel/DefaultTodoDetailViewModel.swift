//
//  DefaultTodoDetailViewModel.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/06.
//

import Foundation
import Combine

protocol TodoDetailViewModelInput {
    func closeButtonDidTap()
    func doneButtonDidTap(title: String, content: String, deadLine: Date)
}
protocol TodoDetailViewModelOutput {
    var item: Just<TodoListModel?> { get }
}
protocol TodoDetailViewModel: TodoDetailViewModelInput, TodoDetailViewModelOutput {}

struct TodoDetailActions {
    let dismiss: () -> Void
}

final class DefaultTodoDetailViewModel: TodoDetailViewModel {
    
    // MARK: - Output
    
    var item: Just<TodoListModel?> {
        return Just(todoListModel)
    }

    private let todoListModel: TodoListModel?
    private let actions: TodoDetailActions
    private let useCase: UseCase
    
    init(actions: TodoDetailActions, useCase: UseCase, todoListModel: TodoListModel?) {
        self.actions = actions
        self.useCase = useCase
        self.todoListModel = todoListModel
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
