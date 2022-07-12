//
//  AppCoordinator.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/06.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController? { get set }
    var parentCoordinator: Coordinator? { get set }
    var childCoordinators: [Coordinator] { get set }
}

final class AppCoordinator: Coordinator {
    weak var navigationController: UINavigationController?
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    
    private let appDIContainer: AppDIContainerable
    
    init(navigationController: UINavigationController, appDIContainer: AppDIContainerable) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }
    
    func start() {
        guard let navigationController = navigationController else {
            return
        }

        let sceneDIContainer = appDIContainer.makeTodoListSceneDIContainer()
        let sceneCoordinator = sceneDIContainer.makeCoordinator(navigationController: navigationController)
        
        childCoordinators.append(sceneCoordinator)
        sceneCoordinator.parentCoordinator = self
        
        sceneCoordinator.start()
    }
}
