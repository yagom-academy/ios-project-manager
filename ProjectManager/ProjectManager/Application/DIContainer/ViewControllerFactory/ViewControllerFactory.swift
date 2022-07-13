//
//  ViewControllerFactory.swift
//  ProjectManager
//
//  Created by 조민호 on 2022/07/12.
//
import Foundation

final class ViewControllerFactory {
    private unowned let storage: Storageable
    private unowned var parentViewModel: TodoListViewModel?
    
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
        return TodoListViewController(viewModel: makeTodoListViewModel(coordinator: coordinator), factory: self)
    }
    
    // MARK: - View
    
    func makeTodoListView() -> TodoListView {
        return TodoListView(factory: self)
    }
    
    func makeTodoView(processType: ProcessType) -> TodoView {
        return TodoView(viewModel: makeTodoViewModel(processType: processType))
    }
    
    // MARK: - ViewModel
    
    private func makeTodoViewModel(processType: ProcessType) -> TodoViewModel {
        let viewModel = TodoViewModel(processType: processType, items: parentViewModel!.items)
        viewModel.delegate = parentViewModel
        
        return viewModel
    }
    
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
        let viewModel = TodoListViewModel(coordinator: coordinator, useCase: makeTodoListUseCase())
        self.parentViewModel = viewModel
        return viewModel
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
