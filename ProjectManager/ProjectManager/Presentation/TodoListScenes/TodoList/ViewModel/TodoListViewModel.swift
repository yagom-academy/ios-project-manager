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
    func cellDidLongPress(_ item: TodoListModel, to processType: ProcessType)
}

protocol TodoListViewModelOutput {
    var todoItems: AnyPublisher<[TodoListModel], Never> { get }
    var doingItems: AnyPublisher<[TodoListModel], Never> { get }
    var doneItems: AnyPublisher<[TodoListModel], Never> { get }
}

protocol TodoListViewModelable: TodoListViewModelInput, TodoListViewModelOutput {}

final class TodoListViewModel: TodoListViewModelable {
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
    
    private weak var coordinator: TodoListViewCoordinator?
    private let useCase: TodoListUseCaseable
    
    init(coordinator: TodoListViewCoordinator, useCase: TodoListUseCaseable) {
        self.useCase = useCase
        self.coordinator = coordinator
    }
    
    private func filteredItems(with type: ProcessType) -> AnyPublisher<[TodoListModel], Never> {
        return useCase.read()
            .compactMap { item in
                return item.filter { $0.processType == type }
            }
            .eraseToAnyPublisher()
    }
}

extension TodoListViewModel {
    
    // MARK: - Input
    
    func addButtonDidTap() {
        let item = TodoListModel.empty
        useCase.create(item)
        coordinator?.showDetailViewController(item)
    }
    
    func deleteItem(_ item: TodoListModel) {
        useCase.delete(item: item)
    }
    
    func cellDidTap(_ item: TodoListModel) {
        coordinator?.showDetailViewController(item)
    }
    
    func cellDidLongPress(_ item: TodoListModel, to processType: ProcessType) {
        let item = TodoListModel(
            title: item.title,
            content: item.content,
            deadLine: item.deadLine,
            processType: processType,
            id: item.id
        )
        useCase.update(item)
    }
}
