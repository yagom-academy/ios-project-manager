//
//  TodoListSceneCoordinator.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/06.
//

import UIKit

protocol TodoListSceneCoordinatorDependencies {
    func makeViewController(actions: TodoListActions) -> TodoListViewController
}

final class TodoListSceneCoordinator {
    private weak var navigationController: UINavigationController?
    private let dependencies: TodoListSceneCoordinatorDependencies
    private weak var viewController: TodoListViewController?
    
    init(navigationController: UINavigationController, dependencies: TodoListSceneCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let viewController = dependencies.makeViewController(actions: makeActions())
        navigationController?.pushViewController(viewController, animated: true)
        
        self.viewController = viewController
    }
    
    private func makeActions() -> TodoListActions {
        
        return TodoListActions(showDetailView: showDetailView)
    }
    
    private func showDetailView(_ item: TodoListModel?) {
        print(#function)
    }
}
