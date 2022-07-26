//
//  TodoCreateDIContainer.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/26.
//

import UIKit

final class TodoCreateDIContainer {
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

extension TodoCreateDIContainer {
    
    // MARK: ViewController
    
    func makeTodoCreateViewContoller() -> TodoCreateViewController {
        return TodoCreateViewController(viewModel: makeTodoCreateViewModel())
    }
    
    // MARK: - ViewModel
    
    private func makeTodoCreateViewModel() -> TodoCreateViewModelable {
        return TodoCreateViewModel(todoUseCase: makeTodoListUseCase(), historyUseCase: makeTodoHistoryUseCase())
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

    // MARK: - Coordiantor
    
    func makeCreateViewCoordinator(navigationController: UINavigationController) -> TodoCreateViewCoordinator {
        return TodoCreateViewCoordinator(navigationController: navigationController, dependencies: self)
    }
}
