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
    func makeTodoMoveViewController(actions: TodoMoveViewModelActions, item: TodoModel) -> TodoMoveViewController
}

final class TodoListFlowCoordinator {
    private weak var navigationController: UINavigationController?
    private let dependencies: TodoListFlowCoordinatorDependencies
    private weak var todoListViewController: TodoListViewController?
    private weak var todoEditViewController: TodoEditViewController?
    private weak var todoMoveViewController: TodoMoveViewController?
    
    init(navigationController: UINavigationController, dependencies: TodoListFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
}

extension TodoListFlowCoordinator {
    func start() {
        let actions = TodoListViewModelActions(presentEditViewController: presentEditViewController,
                                               popoverMoveViewController: popoverMoveViewController,
                                               showErrorAlert: showErrorAlert)
        
        let viewController = dependencies.makeTodoListViewController(actions: actions)
        
        navigationController?.pushViewController(viewController, animated: true)
        todoListViewController = viewController
    }
    
    private func presentEditViewController(item: TodoModel?) {
        let actions = TodoEditViewModelActions(dismiss: dismissEditViewController,
                                               showErrorAlert: showErrorAlert)
        
        let viewController = dependencies.makeTodoEditViewController(actions: actions, item: item)
        viewController.modalPresentationStyle = .formSheet
        todoListViewController?.present(viewController, animated: true)
        todoEditViewController = viewController
    }
    
    private func dismissEditViewController() {
        todoEditViewController?.dismiss(animated: true)
    }
    
    private func popoverMoveViewController(cell: UITableViewCell?, item: TodoModel) {
        let actions = TodoMoveViewModelActions(dismiss: dismissMoveViewController,
                                               showErrorAlert: showErrorAlert)
        
        let viewController = dependencies.makeTodoMoveViewController(actions: actions, item: item)
        viewController.modalPresentationStyle = .popover
        viewController.preferredContentSize = CGSize(width: 300, height: 130)
        viewController.popoverPresentationController?.sourceView = cell
        viewController.popoverPresentationController?.sourceRect = cell?.bounds ?? .zero
        viewController.popoverPresentationController?.permittedArrowDirections = .up
        todoListViewController?.present(viewController, animated: true)
        
        todoMoveViewController = viewController
    }
    
    private func dismissMoveViewController() {
        todoMoveViewController?.dismiss(animated: true)
    }
    
    private func showErrorAlert(message: String) {
        let alertController = UIAlertController(title: "에러", message: message, preferredStyle: .alert)
        alertController.addAction(.init(title: "확인", style: .default))
        todoListViewController?.present(alertController, animated: true, completion: nil)
    }
}
