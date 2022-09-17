//
//  AppCoordinator.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/09.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    private var window: UIWindow?
    var todoListCoordinator: TodoListCoordinator?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    @discardableResult
    func start() -> UIViewController {
        todoListCoordinator = TodoListCoordinator()
        guard let mainVC = todoListCoordinator?.start() else { return UIViewController() }
        self.window?.rootViewController = mainVC
        self.window?.makeKeyAndVisible()
        return mainVC
    }
}
