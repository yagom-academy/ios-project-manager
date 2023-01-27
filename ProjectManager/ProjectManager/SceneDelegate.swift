//
//  ProjectManager - SceneDelegate.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }
        let window = UIWindow(windowScene: windowScene)
        let listViewController = ListViewController()
        let listUseCase = DefaultListUseCase()
        listViewController.viewModel = ListViewModel(listUseCase: listUseCase)
        let navigationController = UINavigationController(rootViewController: listViewController)

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        window.backgroundColor = .systemGray6
        self.window = window
    }
}

