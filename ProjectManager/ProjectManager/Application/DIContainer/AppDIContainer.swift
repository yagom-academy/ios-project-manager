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
    private let storage = RealmStorage()
    private let historyStorage = HistoryStorage()
    
    func makeTodoListSceneDIContainer() -> TodoListSceneDIContainer {
        return TodoListSceneDIContainer(dependencies: TodoListSceneDIContainer.Dependencies(storage: storage))
    }
    
    func makeTodoHistorySceneDIContainer() -> TodoHistorySceneDIContainer {
        return TodoHistorySceneDIContainer(dependencies: TodoHistorySceneDIContainer.Dependencies(storage: historyStorage))
    }
}
