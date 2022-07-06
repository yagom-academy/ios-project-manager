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
    private weak var viewController: UIViewController?
    
    init(navigationController: UINavigationController, dependencies: TodoListSceneCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let todoListViewController = dependencies.makeTodoListViewController(actions: makeTodoListActions())
        navigationController?.pushViewController(todoListViewController, animated: true)
        
        self.viewController = todoListViewController
    }
    
    private func makeTodoListActions() -> TodoListActions {
        return TodoListActions(showDetailView: showDetailView)
    }
    
    private func showDetailView(_ item: TodoListModel?) {
        let todoDetailViewController = dependencies.makeTodoDetailViewContoller(actions: TodoDetailActions())
        todoDetailViewController.modalPresentationStyle = .formSheet
        
        self.viewController?.present(todoDetailViewController, animated: true)
    }
}
