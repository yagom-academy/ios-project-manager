//
//  TodoListViewCoordinator.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/06.
//

import UIKit

final class TodoListViewCoordinator: Coordinator {
    weak var navigationController: UINavigationController?
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    
    private let dependencies: TodoListDIContainer
    private weak var viewController: TodoListViewController?
    
    init(navigationController: UINavigationController, dependencies: TodoListDIContainer) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    // MARK: View Transition
    
    func start() {
        let todoListViewController = dependencies.makeTodoListViewController()
        todoListViewController.coordinator = self
        self.navigationController?.pushViewController(todoListViewController, animated: true)
    }
    
    func showCreateViewController() {
        guard let navigationController = navigationController else {
            return
        }
        
        let factory = dependencies.makeTodoCreateFactory()
        let sceneCoordinator = factory.makeCreateViewCoordinator(navigationController: navigationController)
        
        childCoordinators.append(sceneCoordinator)
        sceneCoordinator.parentCoordinator = self
        
        sceneCoordinator.start()
    }
    
    func showEditViewController(_ item: Todo) {
        guard let navigationController = navigationController else {
            return
        }
        
        let factory = dependencies.makeTodoEditFactory()
        let sceneCoordinator = factory.makeEditViewCoordinator(navigationController: navigationController)
        
        childCoordinators.append(sceneCoordinator)
        sceneCoordinator.parentCoordinator = self
        
        sceneCoordinator.start(item)
    }
    
    func showHistoryViewController(sourceView: UIBarButtonItem) {
        guard let navigationController = navigationController else {
            return
        }
        
        let factory = dependencies.makeTodoHistoryFactory()
        let sceneCoordinator = factory.makeHistoryViewCoordinator(
            navigationController: navigationController
        )
        
        childCoordinators.append(sceneCoordinator)
        sceneCoordinator.parentCoordinator = self
        
        sceneCoordinator.start(sourceView: sourceView)
    }
}
