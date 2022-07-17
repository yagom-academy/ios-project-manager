//
//  TodoListSceneDIContainer.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/06.
//

import UIKit

final class TodoListSceneDIContainer {
    struct Dependencies {
        unowned let storage: Storageable
    }
    
    private let dependencies: Dependencies
    private let viewControllerFactory: ViewControllerFactory
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        self.viewControllerFactory = ViewControllerFactory(storage: dependencies.storage)
    }
}

extension TodoListSceneDIContainer {
    
    // MARK: ViewController
    
    func makeTodoListViewController(coordinator: TodoListViewCoordinator) -> TodoListViewController {
        return viewControllerFactory.makeTodoListViewController(coordinator: coordinator)
    }
    
    func makeTodoDetailViewContoller(todoListModel: TodoListModel, coordinator: TodoDetailViewCoordinator) -> TodoDetailViewController {
        return viewControllerFactory.makeTodoDetailViewContoller(todoListModel: todoListModel, coordinator: coordinator)
    }
    
    // MARK: - Coordiantor
    
    func makeListViewCoordinator(navigationController: UINavigationController) -> TodoListViewCoordinator {
        return TodoListViewCoordinator(navigationController: navigationController, dependencies: self)
    }
    
    func makeDetailViewCoordinator(navigationController: UINavigationController) -> TodoDetailViewCoordinator {
        return TodoDetailViewCoordinator(navigationController: navigationController, dependencies: self)
    }
}
