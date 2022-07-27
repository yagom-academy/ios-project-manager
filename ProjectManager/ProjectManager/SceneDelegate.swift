//
//  ProjectManager - SceneDelegate.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate, UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    private let current = UNUserNotificationCenter.current()

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let mainViewController = UINavigationController(rootViewController: MainViewController())
        let splitViewController = UISplitViewController(style: .doubleColumn)
        let historyTableViewController = UINavigationController(
            rootViewController: HistoryViewController(style: .plain)
        )
        
        splitViewController.viewControllers = [historyTableViewController, mainViewController]
        splitViewController.preferredPrimaryColumnWidthFraction = 1/3
        splitViewController.preferredDisplayMode = .secondaryOnly
        splitViewController.preferredSplitBehavior = .overlay
        
        window?.rootViewController = splitViewController
        window?.makeKeyAndVisible()
        
        configureLocalNotification(viewController: mainViewController)
    }
    
    private func configureLocalNotification(viewController: UIViewController) {
        current.delegate = self
        current.requestAuthorization(options: [.sound, .alert, .badge]) { isAllowed, _ in
            if !isAllowed {
                DispatchQueue.main.async {
                    self.showAlert(viewController: viewController) { _ in
                        self.showSettingURL()
                    }
                }
            }
        }
    }
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions
        ) -> Void) {
        completionHandler([.sound, .banner, .badge])
    }
    
    private func showSettingURL() {
        guard let settingURL = URL(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(settingURL)
    }
    
    private func showAlert(viewController: UIViewController, handler: @escaping ((UIAlertAction) -> Void)) {
        let alert = UIAlertController(title: "알림 권한", message: "서비스를 이용하시려면 알림 권한을 허용해주세요", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: handler)
        alert.addAction(okAction)
        viewController.present(alert, animated: true)
    }
}
