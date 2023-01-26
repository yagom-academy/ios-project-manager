//  ProjectManager - SceneDelegate.swift
//  created by zhilly on 2023/01/11

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let mainViewController = ProjectManagerViewController()
        let navigationController = UINavigationController(rootViewController: mainViewController)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
