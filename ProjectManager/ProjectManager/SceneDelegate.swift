//
//  ProjectManager - SceneDelegate.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = scene as? UIWindowScene else { return }
        let window = UIWindow(windowScene: scene)
        let navigationController = UINavigationController(
            rootViewController: ProjectTodoListViewController(projectTodoListViewModel: ProjectTodoListViewModel())
        )
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }
}
