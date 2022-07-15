//
//  TodoSceneDIContainer.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/08.
//

import UIKit

final class TodoSceneDIContainer {
    private let storage = MemoryTodoListStorege()

    private func makeTodoListViewModel(actions: TodoListViewModelActions) -> DefaultTodoListViewModel {
        return DefaultTodoListViewModel(useCase: makeTodoListUseCase(), actions: actions)
    }
    
    private func makeTodoEditViewModel(actions: TodoEditViewModelActions) -> DefaultTodoEditViewModel {
        return DefaultTodoEditViewModel(useCase: makeTodoListUseCase(), actions: actions)
    }
    
    private func makeTodoListUseCase() -> DefaultTodoListUseCase {
        return DefaultTodoListUseCase(repository: makeTodoListRepository())
    }
    
    private func makeTodoListRepository() -> DefaultTodoListRepository {
        return DefaultTodoListRepository(storage: storage)
    }
}

extension TodoSceneDIContainer: TodoListFlowCoordinatorDependencies {
    func makeTodoListViewController(actions: TodoListViewModelActions) -> TodoListViewController {
        return TodoListViewController(viewModel: makeTodoListViewModel(actions: actions))
    }

    func makeTodoEditViewController(actions: TodoEditViewModelActions, item: TodoModel?) -> TodoEditViewController {
        return TodoEditViewController(viewModel: makeTodoEditViewModel(actions: actions), item: item)

    }
}
