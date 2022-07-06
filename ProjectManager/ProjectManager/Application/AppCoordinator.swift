//
//  AppCoordinator.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/06.
//

import UIKit

final class AppCoordinator {
    private let navigationController: UINavigationController
    private let appDIContainer: AppDIContainer
    
    init(navigationController: UINavigationController, appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }
    
    func start() {
        let sceneDIContainer = appDIContainer.makeTodoListSceneDIContainer()
        let sceneCoordinator = sceneDIContainer.makeCoordinator(navigationController: navigationController)
        
        sceneCoordinator.start()
    }
}
