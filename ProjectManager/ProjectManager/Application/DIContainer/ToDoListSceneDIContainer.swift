//
//  TodoListSceneDIContainer.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/06.
//

import UIKit

final class TodoListSceneDIContainer {
    struct Dependencies {
        let storage: Storageable
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}

extension TodoListSceneDIContainer {
    
    // MARK: ViewController
    
    func makeTodoDetailViewContoller(todoListModel: TodoListModel, coordinator: TodoDetailViewCoordinator) -> TodoDetailViewController {
        return TodoDetailViewController(viewModel: makeTodoDetailViewModel(todoListModel: todoListModel, coordinator: coordinator))
    }
    
    func makeTodoListViewController(coordinator: TodoListViewCoordinator) -> TodoListViewController {
        return TodoListViewController(viewModel: makeTodoListViewModel(coordinator: coordinator))
    }
    
    // MARK: - ViewModel
    
    private func makeTodoDetailViewModel(todoListModel: TodoListModel, coordinator: TodoDetailViewCoordinator) -> TodoDetailViewModelable {
        return TodoDetailViewModel(useCase: makeTodoListUseCase(), todoListModel: todoListModel, coordinator: coordinator)
    }
    
    private func makeTodoListViewModel(coordinator: TodoListViewCoordinator) -> TodoListViewModelable {
        return TodoListViewModel(coordinator: coordinator, useCase: makeTodoListUseCase())
    }
    
    // MARK: - UseCase
    
    private func makeTodoListUseCase() -> TodoListUseCaseable {
        return TodoListUseCase(repository: makeTodoListRepository())
    }
    
    // MARK: - Repository
    
    private func makeTodoListRepository() -> TodoListRepositorible {
        return TodoListRepository(storage: dependencies.storage)
    }
    
    // MARK: - Coordiantor
    
    func makeCoordinator(navigationController: UINavigationController) -> TodoListViewCoordinator {
        return TodoListViewCoordinator(navigationController: navigationController, dependencies: self)
    }
    
    func makeDetailViewCoordinator(navigationController: UINavigationController) -> TodoDetailViewCoordinator {
        return TodoDetailViewCoordinator(navigationController: navigationController, dependencies: self)
    }
}
