//
//  AppDIContainer.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/06.
//

import Foundation

final class AppDIContainer {
    private let storage = MemoryStorage()
    
    func makeTodoListSceneDIContainer() -> TodoListSceneDIContainer {
        TodoListSceneDIContainer(dependencies: TodoListSceneDIContainer.Dependencies(storage: storage))
    }
}
