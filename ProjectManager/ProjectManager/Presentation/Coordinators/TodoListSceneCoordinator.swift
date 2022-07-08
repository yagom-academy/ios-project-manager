//
//  TodoListSceneCoordinator.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/06.
//

import UIKit

protocol TodoListSceneCoordinatorDependencies {
    func makeTodoListViewController(actions: TodoListActions) -> TodoListViewController
    func makeTodoDetailViewContoller(actions: TodoDetailActions) -> TodoDetailViewController
}

final class TodoListSceneCoordinator {
    private weak var navigationController: UINavigationController?
    private let dependencies: TodoListSceneCoordinatorDependencies
    private weak var todoListViewController: TodoListViewController?
    private weak var todoDetailViewController: TodoDetailViewController?
    
    init(navigationController: UINavigationController, dependencies: TodoListSceneCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let todoListViewController = dependencies.makeTodoListViewController(actions: makeTodoListActions())
        navigationController?.pushViewController(todoListViewController, animated: true)
        
        self.todoListViewController = todoListViewController
    }
    
    private func makeTodoListActions() -> TodoListActions {
        return TodoListActions(showDetailView: showTodoDetailView)
    }
    
    private func showTodoDetailView(_ item: TodoListModel?) {
        let todoDetailViewController = dependencies.makeTodoDetailViewContoller(actions: makeTodoDetailActions())
        let todoDetailNavigationController = UINavigationController(rootViewController: todoDetailViewController)
        
        todoDetailNavigationController.modalPresentationStyle = .formSheet
        
        self.todoListViewController?.present(todoDetailNavigationController, animated: true)
        self.todoDetailViewController = todoDetailViewController
    }
    
    private func makeTodoDetailActions() -> TodoDetailActions {
        return TodoDetailActions(dismiss: dismissTodoDetailView)
    }
    
    private func dismissTodoDetailView() {
        self.todoDetailViewController?.dismiss(animated: true)
    }
}
