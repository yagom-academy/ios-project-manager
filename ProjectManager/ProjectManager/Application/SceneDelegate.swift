//
//  SceneDelegate.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/04.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?
  
  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    
    AppAppearance.configureNavigationBar()
    let navigationController = UINavigationController()
    
    window = UIWindow(windowScene: windowScene)
    window?.rootViewController = navigationController
    AppCoordinator(navigationController: navigationController).start()
    window?.makeKeyAndVisible()
  }
}
