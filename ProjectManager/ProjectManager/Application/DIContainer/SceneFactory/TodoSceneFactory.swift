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
    
    func makeTodoListViewController() -> TodoListViewController {
        return TodoListViewController(viewModel: makeTodoListViewModel(), factory: self)
    }
    
    func makeTodoCreateViewContoller() -> TodoCreateViewController {
        return TodoCreateViewController(viewModel: makeTodoCreateViewModel())
    }
    
    func makeTodoEditViewContoller(todoListModel: Todo) -> TodoEditViewController {
        return TodoEditViewController(viewModel: makeTodoEditViewModel(todoListModel: todoListModel))
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
    
    private func makeTodoListViewModel() -> TodoListViewModelable {
        let viewModel = TodoListViewModel(todoUseCase: makeTodoListUseCase(), historyUseCase: makeTodoHistoryUseCase())
        self.parentViewModel = viewModel
        return viewModel
    }
                                      
    private func makeTodoCreateViewModel() -> TodoCreateViewModelable {
        return TodoCreateViewModel(todoUseCase: makeTodoListUseCase(), historyUseCase: makeTodoHistoryUseCase())
    }
    
    private func makeTodoEditViewModel(todoListModel: Todo) -> TodoEditViewModelable {
        return TodoEditViewModel(
            todoUseCase: makeTodoListUseCase(),
            historyUseCase: makeTodoHistoryUseCase(),
            todoListModel: todoListModel
        )
    }
    
    private func makeTodoViewModel(processType: ProcessType) -> TodoViewModel {
        let viewModel = TodoViewModel(
            processType: processType,
            items: parentViewModel?.todoItems ?? Just([Todo]()).eraseToAnyPublisher()
        )
        viewModel.delegate = parentViewModel
        
        return viewModel
    }
    
    private func makeTodoHistoryViewModel() -> TodoHistoryTableViewModelable {
        return TodoHistoryTableViewModel(
            items: parentViewModel?.historyItems ?? Just([TodoHistory]()).eraseToAnyPublisher()
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
        return TodoListRepository(storage: todoStorage)
    }
    
    private func makeTodoHistoryRepository() -> TodoHistoryRepositorible {
        return TodoHistoryRepository(storage: historyStorage)
    }
}
