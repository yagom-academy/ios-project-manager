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
    AppAppearance.configureNavigationBar()
    guard let windowScene = (scene as? UIWindowScene) else { return }
    window = UIWindow(windowScene: windowScene)
    window?.rootViewController = UINavigationController(rootViewController: CardListViewController())
    window?.makeKeyAndVisible()
  }
}
