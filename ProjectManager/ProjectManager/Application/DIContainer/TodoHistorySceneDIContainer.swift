//
//  TodoHistorySceneDIContainer.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/19.
//

import Foundation

final class TodoHistorySceneDIContainer {
    struct Dependencies {
        unowned let storage: HistoryStorageable
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}
