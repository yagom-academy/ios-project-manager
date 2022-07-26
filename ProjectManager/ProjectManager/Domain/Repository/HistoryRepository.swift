//
//  HistoryRepository.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/26.
//

import RxRelay

protocol HistoryStoragable {
    func create(historyEntity: HistoryEntity)
    func read() -> BehaviorRelay<[HistoryEntity]>
}

struct HistoryRepository {
    private let storageManager: HistoryStoragable
    
    init(storageManager: HistoryStoragable) {
        self.storageManager = storageManager
    }
}

extension HistoryRepository: HistoryStoragable {
    func create(historyEntity: HistoryEntity) {
        storageManager.create(historyEntity: historyEntity)
    }
    
    func read() -> BehaviorRelay<[HistoryEntity]> {
        return storageManager.read()
    }
}
