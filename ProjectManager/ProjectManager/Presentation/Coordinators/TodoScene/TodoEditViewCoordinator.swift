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
    
    private unowned let factory: TodoEditFactory

    init(navigationController: UINavigationController, factory: TodoEditFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }

    func start(_ item: Todo) {
        guard let navigationController = navigationController else {
            return
        }

        let todoEditViewController = factory.makeTodoEditViewContoller(item)
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
