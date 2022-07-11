//
//  TodoListFlowCoordinator.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/09.
//

import UIKit

protocol TodoListFlowCoordinatorDependencies {
    func makeTodoListViewController(actions: TodoListViewModelActions) -> TodoListViewController
    func makeTodoEditViewController(actions: TodoEditViewModelActions, item: TodoModel?) -> TodoEditViewController
}

final class TodoListFlowCoordinator {
    private weak var navigationController: UINavigationController?
    private let dependencies: TodoListFlowCoordinatorDependencies
    private weak var todoListViewController: TodoListViewController?
    private weak var todoEditViewController: TodoEditViewController?
    
    init(navigationController: UINavigationController, dependencies: TodoListFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
}

extension TodoListFlowCoordinator {
    func start() {
        let actions = TodoListViewModelActions(presentEditViewController: presentEditViewController)
        
        let viewController = dependencies.makeTodoListViewController(actions: actions)
        
        navigationController?.pushViewController(viewController, animated: true)
        todoListViewController = viewController
    }
    
    private func presentEditViewController(item: TodoModel?) {
        let actions = TodoEditViewModelActions(dismiss: dismissEditViewController)
        
        let viewController = dependencies.makeTodoEditViewController(actions: actions, item: item)
        viewController.modalPresentationStyle = .formSheet
        todoListViewController?.present(viewController, animated: true)
        todoEditViewController = viewController
    }
    
    private func dismissEditViewController() {
        todoEditViewController?.dismiss(animated: true)
    }
}
