//
//  TodoListViewModel.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/06.
//

import Foundation
import Combine

protocol TodoListViewModelInput {
    func deleteItem(_ item: TodoListModel)
}

protocol TodoListViewModelOutput {
    var todoItems: AnyPublisher<[TodoListModel], Never> { get }
}

protocol TodoListViewModel: TodoListViewModelInput, TodoListViewModelOutput {}

struct TodoListActions {}

final class DefaultTodoListViewModel: TodoListViewModel {
        
    // MARK: - Output
    
    var todoItems: AnyPublisher<[TodoListModel], Never> {
        return useCase.read()
    }
    
    private let actions: TodoListActions
    private let useCase: UseCase
    
    init(actions: TodoListActions, useCase: UseCase) {
        self.actions = actions
        self.useCase = useCase
    }
}

extension DefaultTodoListViewModel {
    
    // MARK: - Input
    
    func deleteItem(_ item: TodoListModel) {
        useCase.delete(item: item)
    }
}
