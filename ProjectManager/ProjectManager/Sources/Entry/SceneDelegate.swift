//
//  ProjectManager - SceneDelegate.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)

        let navigationViewController = UINavigationController(rootViewController: PMViewController())
        navigationViewController.setToolbarHidden(false, animated: false)

        window.rootViewController = navigationViewController
        window.makeKeyAndVisible()
        self.window = window
    }
}
