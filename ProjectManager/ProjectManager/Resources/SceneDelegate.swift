//
//  ProjectManager - SceneDelegate.swift
//  Created by brad, bard. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    // MARK: - Properties
    
    var window: UIWindow?

    // MARK: - Functions
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: scene.coordinateSpace.bounds)
        window?.windowScene = scene
        
        let rootViewController = MainViewController()
        let navingationController = UINavigationController(rootViewController: rootViewController)
        window?.rootViewController = navingationController
        window?.makeKeyAndVisible()
        
    }

    func sceneDidDisconnect(_ scene: UIScene) { }

    func sceneDidBecomeActive(_ scene: UIScene) { }

    func sceneWillResignActive(_ scene: UIScene) { }

    func sceneWillEnterForeground(_ scene: UIScene) { }

    func sceneDidEnterBackground(_ scene: UIScene) { }


}

