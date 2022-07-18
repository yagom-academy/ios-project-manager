//
//  AppDIContainer.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/06.
//

import Foundation

protocol AppDIContainerable {
    func makeTodoListSceneDIContainer() -> TodoListSceneDIContainer
}

final class AppDIContainer: AppDIContainerable {
    private let storage = FirebaseStorage()
    
    func makeTodoListSceneDIContainer() -> TodoListSceneDIContainer {
        TodoListSceneDIContainer(dependencies: TodoListSceneDIContainer.Dependencies(storage: storage))
    }
}
