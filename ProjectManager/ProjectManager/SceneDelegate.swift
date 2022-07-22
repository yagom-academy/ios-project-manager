//
//  ProjectManager - SceneDelegate.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
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
        window = UIWindow(windowScene: windowScene)
        let mainViewController = UINavigationController(rootViewController: MainViewController())
        let historyTableViewController = UINavigationController(rootViewController: HistoryViewController())
        let splitViewController = UISplitViewController(style: .doubleColumn)
        splitViewController.viewControllers = [historyTableViewController, mainViewController]
        splitViewController.preferredPrimaryColumnWidthFraction = 1/3
        splitViewController.preferredDisplayMode = .secondaryOnly
        splitViewController.preferredSplitBehavior = .overlay
        
        window?.rootViewController = splitViewController
        window?.makeKeyAndVisible()
    }
}
