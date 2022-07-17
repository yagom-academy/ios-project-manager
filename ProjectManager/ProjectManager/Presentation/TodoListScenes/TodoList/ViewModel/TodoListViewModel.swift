//
//  TodoListViewModel.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/06.
//

import Foundation
import Combine

protocol TodoListViewModelInput {
    func didTapAddButton()
}

protocol TodoListViewModelOutput {
    var items: AnyPublisher<[TodoListModel], Never> { get }
    var title: Just<String> { get }
}

protocol TodoListViewModelable: TodoListViewModelInput, TodoListViewModelOutput {}

final class TodoListViewModel: TodoListViewModelable {
    // MARK: - Output
    
    var items: AnyPublisher<[TodoListModel], Never> {
        return useCase.read().eraseToAnyPublisher()
    }
    
    var title: Just<String> {
        return Just("Project Manager")
    }
    
    private weak var coordinator: TodoListViewCoordinator?
    private let useCase: TodoListUseCaseable
    
    init(coordinator: TodoListViewCoordinator? = nil, useCase: TodoListUseCaseable) {
        self.useCase = useCase
        self.coordinator = coordinator
    }
}

extension TodoListViewModel {
    
    // MARK: - Input
    
    func didTapAddButton() {
        let item = TodoListModel.empty
        useCase.create(item)
        coordinator?.showDetailViewController(item)
    }    
}

extension TodoListViewModel: TodoViewModelInput {
    func deleteItem(_ item: TodoListModel) {
        useCase.delete(item: item)
    }
    
    func didTapCell(_ item: TodoListModel) {
        coordinator?.showDetailViewController(item)
    }
    
    func didTapFirstContextMenu(_ item: TodoListModel) {
        useCase.update(item)
    }
    
    func didTapSecondContextMenu(_ item: TodoListModel) {
        useCase.update(item)
    }
}
