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
    func addButtonDidTap()
    func cellDidTap(_ item: TodoListModel)
}

protocol TodoListViewModelOutput {
    var todoItems: AnyPublisher<[TodoListModel], Never> { get }
    var doingItems: AnyPublisher<[TodoListModel], Never> { get }
    var doneItems: AnyPublisher<[TodoListModel], Never> { get }
}

protocol TodoListViewModel: TodoListViewModelInput, TodoListViewModelOutput {}

struct TodoListActions {
    let showDetailView: (TodoListModel) -> Void
}

final class DefaultTodoListViewModel: TodoListViewModel {
        
    // MARK: - Output
    
    var todoItems: AnyPublisher<[TodoListModel], Never> {
        return filteredItems(with: .todo)
    }
    
    var doingItems: AnyPublisher<[TodoListModel], Never> {
        return filteredItems(with: .doing)
    }
    
    var doneItems: AnyPublisher<[TodoListModel], Never> {
        return filteredItems(with: .done)
    }
    
    private let actions: TodoListActions
    private let useCase: TodoListUseCase
    
    init(actions: TodoListActions, useCase: TodoListUseCase) {
        self.actions = actions
        self.useCase = useCase
    }
    
    private func filteredItems(with type: ProcessType) -> AnyPublisher<[TodoListModel], Never> {
        return useCase.read()
            .compactMap { item in
                return item.filter { $0.processType == type }
            }
            .eraseToAnyPublisher()
    }
}

extension DefaultTodoListViewModel {
    
    // MARK: - Input
    
    func addButtonDidTap() {
        let item = TodoListModel(title: "", content: "", deadLine: Date().endOfTheDay ?? Date())
        actions.showDetailView(item)
        useCase.create(item)
    }
    
    func deleteItem(_ item: TodoListModel) {
        useCase.delete(item: item)
    }
    
    func cellDidTap(_ item: TodoListModel) {
        actions.showDetailView(item)
    }
}
