//
//  TodoEditDIContainer.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/26.
//

import UIKit

final class TodoEditDIContainer {
    struct Dependencies {
        unowned let todoStorage: LocalStorageable
        unowned let remoteStorage: RemoteStorageable
        unowned let historyStorage: HistoryStorageable
    }
    
    private let isFirstLogin = UserDefaults.standard.bool(forKey: "isFirstLogin")
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}

extension TodoEditDIContainer {
    
    // MARK: ViewController
    
    func makeTodoEditViewContoller(todoListModel: Todo) -> TodoEditViewController {
        return TodoEditViewController(viewModel: makeTodoEditViewModel(todoListModel))
    }
    
    // MARK: - ViewModel
    
    private func makeTodoEditViewModel(_ item: Todo) -> TodoEditViewModelable {
        return TodoEditViewModel(
            todoUseCase: makeTodoListUseCase(),
            historyUseCase: makeTodoHistoryUseCase(),
            todoListModel: item
        )
    }

    // MARK: - UseCase
    
    private func makeTodoListUseCase() -> TodoListUseCaseable {
        return TodoListUseCase(repository: makeTodoListRepository())
    }
    
    private func makeTodoHistoryUseCase() -> TodoHistoryUseCaseable {
        return TodoHistoryUseCase(repository: makeTodoHistoryRepository())
    }
    
    // MARK: - Repository
    
    private func makeTodoListRepository() -> TodoListRepositorible {
        return TodoListRepository(
            todoLocalStorage: dependencies.todoStorage,
            todoRemoteStorage: dependencies.remoteStorage,
            isFirstLogin: isFirstLogin
        )
    }
    
    private func makeTodoHistoryRepository() -> TodoHistoryRepositorible {
        return TodoHistoryRepository(storage: dependencies.historyStorage)
    }
    
    // MARK: - Coordinator
    
    func makeEditViewCoordinator(navigationController: UINavigationController) -> TodoEditViewCoordinator {
        return TodoEditViewCoordinator(navigationController: navigationController, dependencies: self)
    }
}
