//
//  ProjectManager - SceneDelegate.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

import FirebaseCore

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    private var appCoorinator: AppCoordinator?
    
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let rootNaivgationController = UINavigationController()
        window?.rootViewController = rootNaivgationController
        window?.makeKeyAndVisible()
        
        setupLibrary()
                
        appCoorinator = AppCoordinator(navigationController: rootNaivgationController, appDIContainer: AppDIContainer())
        appCoorinator?.start()
    }
    
    private func setupLibrary() {
        FirebaseApp.configure()
    }
}
