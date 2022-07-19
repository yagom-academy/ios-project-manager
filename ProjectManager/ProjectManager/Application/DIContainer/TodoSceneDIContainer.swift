//
//  TodoSceneDIContainer.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/06.
//

import UIKit

final class TodoSceneDIContainer {
    struct Dependencies {
        unowned let todoStorage: Storageable
        unowned let historyStorage: HistoryStorageable
    }
    
    private let dependencies: Dependencies
    private let sceneFactory: TodoSceneFactory
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        self.sceneFactory = TodoSceneFactory(dependency: dependencies)
    }
}

extension TodoSceneDIContainer {
    
    // MARK: ViewController
    
    func makeTodoListViewController(coordinator: TodoListViewCoordinator) -> TodoListViewController {
        return sceneFactory.makeTodoListViewController(coordinator: coordinator)
    }
    
    func makeTodoDetailViewContoller(todoListModel: Todo, coordinator: TodoDetailViewCoordinator) -> TodoEditViewController {
        return sceneFactory.makeTodoDetailViewContoller(todoListModel: todoListModel, coordinator: coordinator)
    }
    
    func makeTodoHistoryTableViewController() -> TodoHistoryTableViewController {
        return sceneFactory.makeTodoHistoryViewController()
    }
    
    // MARK: - Coordiantor
    
    func makeListViewCoordinator(navigationController: UINavigationController) -> TodoListViewCoordinator {
        return TodoListViewCoordinator(navigationController: navigationController, dependencies: self)
    }
    
    func makeDetailViewCoordinator(navigationController: UINavigationController) -> TodoDetailViewCoordinator {
        return TodoDetailViewCoordinator(navigationController: navigationController, dependencies: self)
    }
    
    func makeHistoryViewCoordinator(navigationController: UINavigationController) -> TodoHistoryViewCoordinator {
        return TodoHistoryViewCoordinator(navigationController: navigationController, dependencies: self)
    }
}
