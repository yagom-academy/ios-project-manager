//
//  TodoListSceneDIContainer.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/06.
//

import UIKit

final class TodoListSceneDIContainer {
    struct Dependencies {
        let storage: Storage
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}

extension TodoListSceneDIContainer: TodoListSceneCoordinatorDependencies {
    
    // MARK: ViewController
    
    func makeTodoDetailViewContoller(actions: TodoDetailActions, todoListModel: TodoListModel) -> TodoDetailViewController {
        return TodoDetailViewController(viewModel: makeTodoDetailViewModel(actions: actions, todoListModel: todoListModel))
    }
    
    func makeTodoListViewController(actions: TodoListActions) -> TodoListViewController {
        return TodoListViewController(viewModel: makeTodoListViewModel(actions: actions))
    }
    
    // MARK: - ViewModel
    
    private func makeTodoDetailViewModel(actions: TodoDetailActions, todoListModel: TodoListModel) -> TodoDetailViewModel {
        return DefaultTodoDetailViewModel(actions: actions, useCase: makeTodoListUseCase(), todoListModel: todoListModel)
    }
    
    private func makeTodoListViewModel(actions: TodoListActions) -> TodoListViewModel {
        return DefaultTodoListViewModel(actions: actions, useCase: makeTodoListUseCase())
    }
    
    // MARK: - UseCase
    
    private func makeTodoListUseCase() -> TodoListUseCase {
        return DefaultTodoListUseCase(repository: makeTodoListRepository())
    }
    
    // MARK: - Repository
    
    private func makeTodoListRepository() -> TodoListRepository {
        return DefaultTodoListRepository(storage: dependencies.storage)
    }
    
    // MARK: - Coordiantor
    
    func makeCoordinator(navigationController: UINavigationController) -> TodoListSceneCoordinator {
        return TodoListSceneCoordinator(navigationController: navigationController, dependencies: self)
    }
}
