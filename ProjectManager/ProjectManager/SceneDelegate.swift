//
//  ProjectManager - SceneDelegate.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var taskManager = TaskManager()
    
    private func createSampleTasks() {
        taskManager.createTask(title: "1달 전 할일", body: "1줄\n2줄\n3줄", dueDate: Date(timeIntervalSinceNow: -86400 * 30))
        taskManager.createTask(title: "하루 전 할일", body: "1줄\n2줄", dueDate: Date(timeIntervalSinceNow: -86400))
        taskManager.createTask(title: "하루 후 할일", body: "1줄", dueDate: Date(timeIntervalSinceNow: 86400))
        taskManager.createTask(title: "1달 후 할일", body: "1줄\n2줄\n3줄\n4줄", dueDate: Date(timeIntervalSinceNow: 86400 * 30))
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        createSampleTasks()
        let hostingVC = UIHostingController(rootView: MainView().environmentObject(taskManager))
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = hostingVC
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

