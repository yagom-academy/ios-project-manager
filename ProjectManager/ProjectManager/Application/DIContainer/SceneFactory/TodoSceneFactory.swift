//
//  TodoListSceneFactory.swift
//  ProjectManager
//
//  Created by 조민호 on 2022/07/12.
//
import Foundation
import Combine

final class TodoSceneFactory {
    private unowned let todoStorage: Storageable
    private unowned let historyStorage: HistoryStorageable
    private unowned var parentViewModel: TodoListViewModel?
    
    init(dependency: TodoSceneDIContainer.Dependencies) {
        self.historyStorage = dependency.historyStorage
        self.todoStorage = dependency.todoStorage
    }
    
    // MARK: ViewController
    
    func makeTodoListViewController(coordinator: TodoListViewCoordinator) -> TodoListViewController {
        return TodoListViewController(viewModel: makeTodoListViewModel(coordinator: coordinator), factory: self)
    }
    
    func makeTodoDetailViewContoller(
        todoListModel: Todo,
        coordinator: TodoDetailViewCoordinator
    ) -> TodoDetailViewController {
        return TodoDetailViewController(
            viewModel: makeTodoDetailViewModel(
                todoListModel: todoListModel,
                coordinator: coordinator
            )
        )
    }
    
    func makeTodoHistoryViewController() -> TodoHistoryTableViewController {
        return TodoHistoryTableViewController(makeTodoHistoryViewModel())
    }
    
    // MARK: - View
    
    func makeTodoListView() -> TodoListView {
        return TodoListView(factory: self)
    }
    
    func makeTodoView(processType: ProcessType) -> TodoView {
        return TodoView(viewModel: makeTodoViewModel(processType: processType))
    }
    
    // MARK: - ViewModel
    
    private func makeTodoListViewModel(coordinator: TodoListViewCoordinator) -> TodoListViewModelable {
        let viewModel = TodoListViewModel(coordinator: coordinator, useCase: makeTodoListUseCase())
        self.parentViewModel = viewModel
        return viewModel
    }
    
    private func makeTodoDetailViewModel(
        todoListModel: Todo,
        coordinator: TodoDetailViewCoordinator
    ) -> TodoDetailViewModelable {
        return TodoDetailViewModel(
            useCase: makeTodoListUseCase(),
            todoListModel: todoListModel,
            coordinator: coordinator
        )
    }
    
    private func makeTodoViewModel(processType: ProcessType) -> TodoViewModel {
        let viewModel = TodoViewModel(
            processType: processType,
            items: parentViewModel?.items ?? Just([Todo]()).eraseToAnyPublisher()
        )
        viewModel.delegate = parentViewModel
        
        return viewModel
    }
    
    private func makeTodoHistoryViewModel() -> TodoHistoryTableViewModelable {
        return TodoHistoryTableViewModel(useCase: makeTodoHistoryUseCase())
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
        return TodoListRepository(storage: todoStorage)
    }
    
    private func makeTodoHistoryRepository() -> TodoHistoryRepositorible {
        return TodoHistoryRepository(storage: historyStorage)
    }
}
