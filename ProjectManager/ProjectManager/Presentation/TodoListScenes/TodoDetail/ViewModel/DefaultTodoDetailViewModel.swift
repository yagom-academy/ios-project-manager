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
    func editButtonDidTap()
}
protocol TodoDetailViewModelOutput {
    var item: Just<TodoListModel?> { get }
    var isCreate: CurrentValueSubject<Bool, Never> { get }
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
    
    let isCreate = CurrentValueSubject<Bool, Never>(true)

    private let todoListModel: TodoListModel?
    private let actions: TodoDetailActions
    private let useCase: UseCase
    
    init(actions: TodoDetailActions, useCase: UseCase, todoListModel: TodoListModel?) {
        self.actions = actions
        self.useCase = useCase
        self.todoListModel = todoListModel
        
        if todoListModel?.title == "" && todoListModel?.content == "" {
            isCreate.send(true)
        } else {
            isCreate.send(false)
        }
    }
}

extension DefaultTodoDetailViewModel {
    
    // MARK: - Input
    
    func closeButtonDidTap() {
        if todoListModel?.title == "" && todoListModel?.content == "" {
            useCase.deleteLastItem()
        }
        
        actions.dismiss()
    }
    
    func doneButtonDidTap(title: String, content: String, deadLine: Date) {
        useCase.update(TodoListModel(title: title, content: content, deadLine: deadLine, id: todoListModel!.id))
        actions.dismiss()
    }
    
    func editButtonDidTap() {
        isCreate.send(true)
    }
}
