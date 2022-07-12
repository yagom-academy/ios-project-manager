//
//  ViewControllerFactory.swift
//  ProjectManager
//
//  Created by 조민호 on 2022/07/12.
//

final class ViewControllerFactory {
    private let storage: Storageable
    
    init(storage: Storageable) {
        self.storage = storage
    }
    
    // MARK: ViewController
    
    func makeTodoDetailViewContoller(
        todoListModel: TodoListModel,
        coordinator: TodoDetailViewCoordinator
    ) -> TodoDetailViewController {
        return TodoDetailViewController(
            viewModel: makeTodoDetailViewModel(
                todoListModel: todoListModel,
                coordinator: coordinator
            )
        )
    }
    
    func makeTodoListViewController(coordinator: TodoListViewCoordinator) -> TodoListViewController {
        return TodoListViewController(viewModel: makeTodoListViewModel(coordinator: coordinator))
    }
    
    // MARK: - ViewModel
    
    private func makeTodoDetailViewModel(
        todoListModel: TodoListModel,
        coordinator: TodoDetailViewCoordinator
    ) -> TodoDetailViewModelable {
        return TodoDetailViewModel(
            useCase: makeTodoListUseCase(),
            todoListModel: todoListModel,
            coordinator: coordinator
        )
    }
    
    private func makeTodoListViewModel(coordinator: TodoListViewCoordinator) -> TodoListViewModelable {
        return TodoListViewModel(coordinator: coordinator, useCase: makeTodoListUseCase())
    }
    
    // MARK: - UseCase
    
    private func makeTodoListUseCase() -> TodoListUseCaseable {
        return TodoListUseCase(repository: makeTodoListRepository())
    }
    
    // MARK: - Repository
    
    private func makeTodoListRepository() -> TodoListRepositorible {
        return TodoListRepository(storage: storage)
    }
}
