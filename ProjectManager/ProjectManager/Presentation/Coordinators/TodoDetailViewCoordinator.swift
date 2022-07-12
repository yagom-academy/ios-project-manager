//
//  TodoDetailViewCoordinator.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/12.
//

import UIKit

final class TodoDetailViewCoordinator: Coordinator {
    weak var navigationController: UINavigationController?
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    
    private let dependencies: TodoListSceneDIContainer

    init(navigationController: UINavigationController, dependencies: TodoListSceneDIContainer) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }

    func start(_ item: TodoListModel) {
        guard let navigationController = navigationController else {
            return
        }

        let todoDetailViewController = dependencies.makeTodoDetailViewContoller(todoListModel: item, coordinator: self)
        let todoDetailNavigationController = UINavigationController(rootViewController: todoDetailViewController)
        todoDetailNavigationController.modalPresentationStyle = .formSheet
        
        navigationController.topViewController?.present(todoDetailNavigationController, animated: true)
        
        self.navigationController = todoDetailNavigationController
    }
    
    func dismiss() {
        navigationController?.dismiss(animated: true)
        
        parentCoordinator?.childCoordinators.removeAll { $0 === self }
    }
}
