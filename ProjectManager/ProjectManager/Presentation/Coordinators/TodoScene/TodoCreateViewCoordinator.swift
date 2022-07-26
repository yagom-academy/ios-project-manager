//
//  TodoCreateViewCoordinator.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/19.
//

import UIKit

final class TodoCreateViewCoordinator: Coordinator {
    weak var navigationController: UINavigationController?
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    
    private unowned let dependencies: TodoCreateDIContainer

    init(navigationController: UINavigationController, dependencies: TodoCreateDIContainer) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }

    func start() {
        guard let navigationController = navigationController else {
            return
        }

        let todoCreateViewController = dependencies.makeTodoCreateViewContoller()
        todoCreateViewController.coordinator = self
        
        let todoCreateNavigationController = UINavigationController(rootViewController: todoCreateViewController)
        todoCreateNavigationController.modalPresentationStyle = .formSheet
        
        navigationController.topViewController?.present(todoCreateNavigationController, animated: true)
        self.navigationController = todoCreateNavigationController
    }
    
    func dismiss() {
        navigationController?.dismiss(animated: true)
        parentCoordinator?.removeChild(self)
    }
}
