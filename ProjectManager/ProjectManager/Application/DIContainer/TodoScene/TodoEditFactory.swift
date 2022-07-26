//
//  TodoEditDIContainer.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/26.
//

import UIKit

final class TodoEditFactory {
    struct Dependencies {
        let todoListUseCase: TodoListUseCaseable
        let todoHistoryUseCase: TodoHistoryUseCaseable
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}

extension TodoEditFactory {
    func makeTodoEditViewContoller(_ item: Todo) -> TodoEditViewController {
        return TodoEditViewController(viewModel: makeTodoEditViewModel(item))
    }

    private func makeTodoEditViewModel(_ item: Todo) -> TodoEditViewModelable {
        return TodoEditViewModel(
            todoUseCase: dependencies.todoListUseCase,
            historyUseCase: dependencies.todoHistoryUseCase,
            item: item
        )
    }

    func makeEditViewCoordinator(navigationController: UINavigationController) -> TodoEditViewCoordinator {
        return TodoEditViewCoordinator(navigationController: navigationController, factory: self)
    }
}
