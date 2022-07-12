//
//  TodoListSceneCoordinator.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/06.
//

import UIKit

protocol TodoListSceneCoordinatorDependencies {
    func makeTodoListViewController() -> TodoListViewController
    func makeTodoDetailViewContoller(todoListModel: TodoListModel) -> TodoDetailViewController
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
    
    // MARK: View Transition
    
    func start() {
        let todoListViewController = dependencies.makeTodoListViewController()
        navigationController?.pushViewController(todoListViewController, animated: true)
        
        self.todoListViewController = todoListViewController
    }
    
    private func showTodoDetailView(_ item: TodoListModel) {
        let todoDetailViewController = dependencies.makeTodoDetailViewContoller(todoListModel: item)
        let todoDetailNavigationController = UINavigationController(rootViewController: todoDetailViewController)
        
        todoDetailNavigationController.modalPresentationStyle = .formSheet
        
        self.todoListViewController?.present(todoDetailNavigationController, animated: true)
        self.todoDetailViewController = todoDetailViewController
    }
    
    private func dismissTodoDetailView() {
        self.todoDetailViewController?.dismiss(animated: true)
    }
}
