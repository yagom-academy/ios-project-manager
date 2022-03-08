//
//  ProjectManager - SceneDelegate.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let dataSource = MemoryDataSource()
        dataSource.storage = [
            Schedule(title: "1번 스케줄", body: "ㅇㅇㅇ", dueDate: Date(), progress: .doing),
            Schedule(title: "2번 스케줄", body: "ㅇㅇㅇ", dueDate: Date(), progress: .done),
            Schedule(title: "3번 스케줄", body: "ㅇㅇㅇ", dueDate: Date(), progress: .doing),
            Schedule(title: "4번 스케줄", body: "ㅇㅇㅇ", dueDate: Date(), progress: .todo),
            Schedule(title: "5번 스케줄", body: "ㅇㅇㅇ", dueDate: Date(), progress: .doing)
        ]

        let rootViewController = MainViewController(viewModel: MainViewModel(useCase: ScheduleUseCase(repository: DataRepository(dataSource: dataSource))))
        let navigationController = UINavigationController(rootViewController: rootViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }


}

