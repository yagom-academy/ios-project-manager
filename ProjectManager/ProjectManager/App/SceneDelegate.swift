//
//  ProjectManager - SceneDelegate.swift
//  Created by Finnn.
//  Copyright © Finnn. All rights reserved.
// 

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let newWindow = UIWindow(windowScene: windowScene)
        newWindow.rootViewController = UINavigationController(rootViewController: ProjectManagerViewController())
        newWindow.makeKeyAndVisible()
        self.window = newWindow
    }
}
