//
//  TodoDetailViewCoordinator.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/12.
//

import UIKit

final class TodoEditViewCoordinator: Coordinator {
    weak var navigationController: UINavigationController?
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    
    private unowned let dependencies: TodoListDIContainer

    init(navigationController: UINavigationController, dependencies: TodoListDIContainer) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }

    func start(_ item: Todo) {
        guard let navigationController = navigationController else {
            return
        }

        let todoEditViewController = dependencies.makeTodoEditViewContoller(todoListModel: item)
        todoEditViewController.coordiantor = self
        
        let todoEditNavigationController = UINavigationController(rootViewController: todoEditViewController)
        todoEditNavigationController.modalPresentationStyle = .formSheet
        
        navigationController.topViewController?.present(todoEditNavigationController, animated: true)
        self.navigationController = todoEditNavigationController
    }
    
    func dismiss() {
        navigationController?.dismiss(animated: true)
        parentCoordinator?.removeChild(self)
    }
}
