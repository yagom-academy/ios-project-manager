//
//  HistoryRepository.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/26.
//

import RxRelay

protocol HistoryRepositoryProtocol {
    var storageManager: HistoryManagerProtocol { get }
    func create(historyEntity: HistoryEntity)
    func read() -> BehaviorRelay<[HistoryEntity]>
}

struct HistoryRepository: HistoryRepositoryProtocol {
    let storageManager: HistoryManagerProtocol
    
    init(storageManager: HistoryManagerProtocol) {
        self.storageManager = storageManager
    }
}

extension HistoryRepository {
    func create(historyEntity: HistoryEntity) {
        storageManager.create(historyEntity: historyEntity)
    }
    
    func read() -> BehaviorRelay<[HistoryEntity]> {
        return storageManager.read()
    }
}
