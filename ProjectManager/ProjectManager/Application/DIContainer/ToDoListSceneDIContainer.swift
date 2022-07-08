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
    func makeTodoDetailViewContoller(actions: TodoDetailActions, todoListModel: TodoListModel?) -> TodoDetailViewController {
        return TodoDetailViewController(viewModel: makeTodoDetailViewModel(actions: actions, todoListModel: todoListModel))
    }
    
    private func makeTodoDetailViewModel(actions: TodoDetailActions, todoListModel: TodoListModel?) -> TodoDetailViewModel {
        DefaultTodoDetailViewModel(actions: actions, useCase: makeUseCase(), todoListModel: todoListModel)
    }
    
    func makeTodoListViewController(actions: TodoListActions) -> TodoListViewController {
        return TodoListViewController(viewModel: makeTodoListViewModel(actions: actions))
    }
    
    private func makeTodoListViewModel(actions: TodoListActions) -> TodoListViewModel {
        DefaultTodoListViewModel(actions: actions, useCase: makeUseCase())
    }
    
    private func makeUseCase() -> UseCase {
        TodoListUseCase(repository: makeRepository())
    }
    
    private func makeRepository() -> Repository {
        return TodoListRepository(storage: dependencies.storage)
    }
    
    func makeCoordinator(navigationController: UINavigationController) -> TodoListSceneCoordinator {
        TodoListSceneCoordinator(navigationController: navigationController, dependencies: self)
    }
}
