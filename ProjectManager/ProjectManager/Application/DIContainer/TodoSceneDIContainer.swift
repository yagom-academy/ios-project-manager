//
//  TodoSceneDIContainer.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/08.
//

import UIKit

final class TodoSceneDIContainer {
    private let storage = RealmTodoListStorege()

    private func makeTodoListViewModel(actions: TodoListViewModelActions) -> DefaultTodoListViewModel {
        return DefaultTodoListViewModel(useCase: makeTodoListUseCase(), actions: actions)
    }
    
    private func makeTodoEditViewModel(actions: TodoEditViewModelActions, item: TodoModel?) -> DefaultTodoEditViewModel {
        return DefaultTodoEditViewModel(useCase: makeTodoListUseCase(),
                                        actions: actions,
                                        item: item)
    }
    
    private func makeTodoListUseCase() -> DefaultTodoListUseCase {
        return DefaultTodoListUseCase(repository: makeTodoListRepository())
    }
    
    private func makeTodoMoveViewModel(actions: TodoMoveViewModelActions, item: TodoModel) -> TodoMoveViewModel {
        return DefaultTodoMoveViewModel(useCase: makeTodoListUseCase(), actions: actions, item: item)
    }
    
    private func makeTodoListRepository() -> DefaultTodoListRepository {
        return DefaultTodoListRepository(storage: storage)
    }
}

extension TodoSceneDIContainer: TodoListFlowCoordinatorDependencies {
    func makeTodoMoveViewController(actions: TodoMoveViewModelActions, item: TodoModel) -> TodoMoveViewController {
        return TodoMoveViewController(viewModel: makeTodoMoveViewModel(actions: actions, item: item))
    }
    
    func makeTodoListViewController(actions: TodoListViewModelActions) -> TodoListViewController {
        return TodoListViewController(viewModel: makeTodoListViewModel(actions: actions))
    }

    func makeTodoEditViewController(actions: TodoEditViewModelActions, item: TodoModel?) -> TodoEditViewController {
        return TodoEditViewController(viewModel: makeTodoEditViewModel(actions: actions, item: item))

    }
}
