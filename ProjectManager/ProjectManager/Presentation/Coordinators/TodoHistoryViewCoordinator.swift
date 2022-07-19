//
//  TodoHistoryViewCoordinator.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/19.
//

import UIKit

final class TodoHistoryViewCoordinator: Coordinator {
    weak var navigationController: UINavigationController?
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    
    private let dependencies: TodoHistorySceneDIContainer
    
    init(navigationController: UINavigationController, dependencies: TodoHistorySceneDIContainer) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
}
