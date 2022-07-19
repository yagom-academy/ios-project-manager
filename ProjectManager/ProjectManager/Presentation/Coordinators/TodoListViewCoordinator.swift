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
    
    private let dependencies: TodoListSceneDIContainer
    
    init(navigationController: UINavigationController, dependencies: TodoListSceneDIContainer) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    // MARK: View Transition
    
    func start() {
        let todoListViewController = dependencies.makeTodoListViewController(coordinator: self)
        self.navigationController?.pushViewController(todoListViewController, animated: true)
    }
    
    func showDetailViewController(_ item: Todo) {
        guard let navigationController = navigationController else {
            return
        }

        let sceneCoordinator = dependencies.makeDetailViewCoordinator(navigationController: navigationController)
        
        childCoordinators.append(sceneCoordinator)
        sceneCoordinator.parentCoordinator = self
        
        sceneCoordinator.start(item)
    }
    
    func showHistoryViewController() {
        guard let navigationController = navigationController else {
            return
        }
    }
}
