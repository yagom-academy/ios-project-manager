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

extension TodoListSceneDIContainer: TodoListSceneCoordinatorDependencies {
    
    // MARK: ViewController
    
    func makeTodoDetailViewContoller(todoListModel: TodoListModel) -> TodoDetailViewController {
        return TodoDetailViewController(viewModel: makeTodoDetailViewModel(todoListModel: todoListModel))
    }
    
    func makeTodoListViewController() -> TodoListViewController {
        return TodoListViewController(viewModel: makeTodoListViewModel())
    }
    
    // MARK: - ViewModel
    
    private func makeTodoDetailViewModel(todoListModel: TodoListModel) -> TodoDetailViewModelable {
        return TodoDetailViewModel(useCase: makeTodoListUseCase(), todoListModel: todoListModel)
    }
    
    private func makeTodoListViewModel() -> TodoListViewModelable {
        return TodoListViewModel(useCase: makeTodoListUseCase())
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
    
    func makeCoordinator(navigationController: UINavigationController) -> TodoListSceneCoordinator {
        return TodoListSceneCoordinator(navigationController: navigationController, dependencies: self)
    }
}
