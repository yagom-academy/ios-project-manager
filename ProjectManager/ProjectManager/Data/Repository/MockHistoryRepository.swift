//
//  MockHistoryRepository.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/25.
//

import RxRelay

final class MockHistoryRepository {
    static let shared = MockHistoryRepository()
    
    private init() { }
    
    private var historyEntities = BehaviorRelay<[HistoryEntity]>(value: [])
}

extension MockHistoryRepository: HistoryStoragable {
    func create(historyEntity: HistoryEntity) {
        var currentProject = read().value
        
        currentProject.append(historyEntity)
        historyEntities.accept(currentProject)
    }
    
    func read() -> BehaviorRelay<[HistoryEntity]> {
        return historyEntities
    }
}
