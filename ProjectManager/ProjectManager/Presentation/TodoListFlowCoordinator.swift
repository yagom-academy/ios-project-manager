//
//  TodoListFlowCoordinator.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/09.
//

import UIKit

protocol TodoListFlowCoordinatorDependencies {
    func makeTodoListViewController(coordinator: TodoListViewControllerDependencies) -> TodoListViewController
    func makeTodoEditViewController(item: TodoModel?,
                                    coordinator: TodoEditViewControllerDependencies) -> TodoEditViewController
    func makeTodoMoveViewController(item: TodoModel,
                                    coordinator: TodoMoveViewControllerDependencies) -> TodoMoveViewController
    func makeHistoryViewController(coordinator: HistoryViewControllerDependencies) -> HistoryViewController
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
        let viewController = dependencies.makeTodoListViewController(coordinator: self)
        
        navigationController?.pushViewController(viewController, animated: true)
        todoListViewController = viewController
    }
}

extension TodoListFlowCoordinator: TodoListViewControllerDependencies {
    func presentEditViewController(item: TodoModel?) {
        let viewController = dependencies.makeTodoEditViewController(item: item, coordinator: self)
        viewController.modalPresentationStyle = .formSheet
        todoListViewController?.present(viewController, animated: true)
        todoEditViewController = viewController
    }
    
    func popoverMoveViewController(cell: UITableViewCell?, item: TodoModel) {
        let viewController = dependencies.makeTodoMoveViewController(item: item, coordinator:  self)
        viewController.modalPresentationStyle = .popover
        viewController.preferredContentSize = CGSize(width: 300, height: 130)
        viewController.popoverPresentationController?.sourceView = cell
        viewController.popoverPresentationController?.sourceRect = cell?.bounds ?? .zero
        viewController.popoverPresentationController?.permittedArrowDirections = .up
        todoListViewController?.present(viewController, animated: true)
        
        todoMoveViewController = viewController
    }
    
    func showErrorAlert(message: String) {
        let alertController = UIAlertController(title: "에러", message: message, preferredStyle: .alert)
        alertController.addAction(.init(title: "확인", style: .default))
        todoListViewController?.present(alertController, animated: true, completion: nil)
    }
}

extension TodoListFlowCoordinator: TodoEditViewControllerDependencies {
    func dismissEditViewController() {
        todoEditViewController?.dismiss(animated: true)
    }
}

extension TodoListFlowCoordinator: TodoMoveViewControllerDependencies {
    func dismissMoveViewController() {
        todoMoveViewController?.dismiss(animated: true)
    }
}
