//
//  TodoListViewModel.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/06.
//

import Foundation

protocol TodoListViewModelInput {}
protocol TodoListViewModelOutput {}
protocol TodoListViewModel: TodoListViewModelInput, TodoListViewModelOutput {}

struct TodoListActions {}

final class DefaultTodoListViewModel: TodoListViewModel {
    private let actions: TodoListActions
    private let useCase: UseCase
    
    init(actions: TodoListActions, useCase: UseCase) {
        self.actions = actions
        self.useCase = useCase
    }
}
