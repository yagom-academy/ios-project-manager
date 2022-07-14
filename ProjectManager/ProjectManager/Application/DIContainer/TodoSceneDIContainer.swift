//
//  TodoSceneDIContainer.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/08.
//

import UIKit

final class TodoSceneDIContainer {
    let storage = MemoryTodoListStorege()

    private func makeTodoListViewModel(actions: TodoListViewModelActions) -> DefaultTodoListViewModel {
        return DefaultTodoListViewModel(useCase: makeTodoListUseCase(), actions: actions)
    }
    
    private func makeTodoEditViewModel(actions: TodoEditViewModelActions) -> DefaultTodoEditViewModel {
        return DefaultTodoEditViewModel(useCase: makeTodoListUseCase(), actions: actions)
    }
    
    private func makeTodoMoveViewModel(actions: TodoMoveViewModelActions) -> TodoMoveViewModel {
        return DefaultTodoMoveViewModel(useCase: makeTodoListUseCase(), actions: actions)
    }
    
    private func makeTodoListUseCase() -> TodoListUseCase {
        return TodoListUseCase(repository: makeTodoListRepository())
    }
    
    private func makeTodoListRepository() -> DefaultTodoListRepository {
        return DefaultTodoListRepository(storage: storage)
    }
}

extension TodoSceneDIContainer: TodoListFlowCoordinatorDependencies {
    func makeTodoMoveViewController(actions: TodoMoveViewModelActions, item: TodoModel) -> TodoMoveViewController {
        return TodoMoveViewController(viewModel: makeTodoMoveViewModel(actions: actions), item: item)
    }
    
    func makeTodoListViewController(actions: TodoListViewModelActions) -> TodoListViewController {
        return TodoListViewController(viewModel: makeTodoListViewModel(actions: actions))
    }

    func makeTodoEditViewController(actions: TodoEditViewModelActions, item: TodoModel?) -> TodoEditViewController {
        return TodoEditViewController(viewModel: makeTodoEditViewModel(actions: actions), item: item)
    }
}
