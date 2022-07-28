//
//  TodoSceneDIContainer.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/08.
//

import Foundation

final class TodoSceneDIContainer {
    private let todoListStorage = RealmTodoListStorage()
    private let historyStorage = RealmHistoryStorage()
    private let backUpStorage = FirebaseTodoListStorage()
    private let userStateStorage = UserDefaults()

    private func makeTodoListViewModel() -> DefaultTodoListViewModel {
        return DefaultTodoListViewModel(useCase: makeTodoListUseCase())
    }
    
    private func makeTodoEditViewModel(item: TodoModel?) -> DefaultTodoEditViewModel {
        return DefaultTodoEditViewModel(useCase: makeTodoListUseCase(),
                                        item: item)
    }
    
    private func makeTodoMoveViewModel(item: TodoModel) -> TodoMoveViewModel {
        return DefaultTodoMoveViewModel(useCase: makeTodoListUseCase(), item: item)
    }
    
    private func makeHistoryViewModel() -> HistoryViewModel {
        return DefaultTodoHistoryViewModel(useCase: makeTodoListUseCase())
    }
    
    private func makeTodoListUseCase() -> DefaultTodoListUseCase {
        return DefaultTodoListUseCase(listRepository: makeTodoListRepository(),
                                      historyRepository: makeHistoryRepository())
    }
    
    private func makeTodoListRepository() -> DefaultTodoListRepository {
        return DefaultTodoListRepository(storage: todoListStorage, backUpStorage: backUpStorage, userStateStorage: userStateStorage)
    }
    
    private func makeHistoryRepository() -> DefaultHistoryRepository {
        return DefaultHistoryRepository(storage: historyStorage)
    }
}

extension TodoSceneDIContainer: TodoListFlowCoordinatorDependencies {
    func makeTodoMoveViewController(item: TodoModel,
                                    coordinator: TodoMoveViewControllerDependencies) -> TodoMoveViewController {
        return TodoMoveViewController(viewModel: makeTodoMoveViewModel(item: item),
                                      coordinator: coordinator)
    }
    
    func makeTodoListViewController(coordinator: TodoListViewControllerDependencies) -> TodoListViewController {
        return TodoListViewController(viewModel: makeTodoListViewModel(),
                                      coordinator: coordinator)
    }

    func makeTodoEditViewController(item: TodoModel?,
                                    coordinator: TodoEditViewControllerDependencies) -> TodoEditViewController {
        return TodoEditViewController(viewModel: makeTodoEditViewModel(item: item),
                                      coordinator: coordinator)

    }
    
    func makeHistoryViewController(coordinator: HistoryViewControllerDependencies) -> HistoryViewController {
        return HistoryViewController(viewModel: makeHistoryViewModel(),
                                         coordinator: coordinator)
    }
}
