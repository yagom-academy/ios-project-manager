//
//  MockHistoryRepository.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/25.
//

import Foundation

final class MockHistoryRepository {
    static let shared = MockHistoryRepository()
    
    private init() { }
    
    private var historyEntities = [HistoryEntity]()
}

extension MockHistoryRepository: HistoryStoragable {
    func create(historyEntity: HistoryEntity) {
        historyEntities.append(historyEntity)
    }
    
    func read() -> [HistoryEntity] {
        return historyEntities
    }
}
