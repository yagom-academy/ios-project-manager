//
//  ProjectManager - SceneDelegate.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    let storege = MemoryTodoListStorege()
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = UINavigationController(rootViewController: TodoListViewController(viewModel: makeTodoListViewModel()))
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}

private extension SceneDelegate {
    func makeTodoListViewModel() -> DefaultTodoListViewModel {
        return DefaultTodoListViewModel(useCase: makeTodoListUseCase())
    }
    
    func makeTodoListUseCase() -> TodoListUseCase {
        return TodoListUseCase(repository: makeTodoListRepository())
    }
    
    func makeTodoListRepository() -> DefaultTodoListRepository {
        return DefaultTodoListRepository(storege: storege)
    }
}
