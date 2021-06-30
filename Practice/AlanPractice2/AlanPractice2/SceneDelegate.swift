//
//  SceneDelegate.swift
//  AlanPractice2
//  Created by YB on 2021/06/30.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let mainViewController = ViewController()
//        let navigationController = UINavigationController(rootViewController: mainViewController)
        
        window?.rootViewController = mainViewController
//        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
