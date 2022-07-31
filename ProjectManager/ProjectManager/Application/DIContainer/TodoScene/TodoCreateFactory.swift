//
//  TodoCreateFactory.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/26.
//

import UIKit

final class TodoCreateFactory {
    struct Dependencies {
        let todoListUseCase: TodoListUseCaseable
        let todoHistoryUseCase: TodoHistoryUseCaseable
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}

extension TodoCreateFactory {
    func makeTodoCreateViewContoller() -> TodoCreateViewController {
        return TodoCreateViewController(viewModel: makeTodoCreateViewModel())
    }

    private func makeTodoCreateViewModel() -> TodoCreateViewModelable {
        return TodoCreateViewModel(
            todoUseCase: dependencies.todoListUseCase,
            historyUseCase: dependencies.todoHistoryUseCase
        )
    }

    func makeCreateViewCoordinator(navigationController: UINavigationController) -> TodoCreateViewCoordinator {
        return TodoCreateViewCoordinator(navigationController: navigationController, factory: self)
    }
}
