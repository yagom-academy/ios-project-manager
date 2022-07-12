//
//  ProjectManager - SceneDelegate.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var coordinator: MainCoordinator?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        let navigationController = UINavigationController()
        
        self.window?.rootViewController = navigationController
        coordinator = MainCoordinator(navigationController: navigationController)
        coordinator?.start()
        self.window?.makeKeyAndVisible()
    }
}
