//
//  ProjectManager - SceneDelegate.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import RealmSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        guard let realm = try? Realm() else {
            showErrorViewController()
            return
        }
        
        let container = Container(storage: AppStorage(LocalStorageManager(networkStorageManager: NetworkStorageManager(), realm: realm)))
        window?.rootViewController = container.makeMainViewController()
        window?.makeKeyAndVisible()
    }
    
    private func showErrorViewController() {
        window?.rootViewController = UIViewController()
        window?.makeKeyAndVisible()
        window?.rootViewController?
            .showExitAlert(message: StorageError.localStorageError.errorDescription)
    }
}

