//
//  MockHistoryManager.swift
//  ProjectManagerTests
//
//  Created by Tiana, mmim on 2022/07/29.
//

@testable import ProjectManager
import RxRelay

final class MockHistoryManager {
    var historyEntities = BehaviorRelay<[HistoryEntity]>(value: [])
}

extension MockHistoryManager: HistoryManagerProtocol {
    func create(historyEntity: HistoryEntity) {
        var currentProject = read().value
        
        currentProject.append(historyEntity)
        historyEntities.accept(currentProject)
    }
    
    func read() -> BehaviorRelay<[HistoryEntity]> {
        return historyEntities
    }
}
