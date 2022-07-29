//
//  HistoryStorage.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/29.
//

import RxRelay

protocol HistoryStorageProtocol {
    func create(historyEntity: HistoryEntity)
    func read() -> BehaviorRelay<[HistoryEntity]>
}

final class HistoryStorage {
    private let historyManager: HistoryManagerProtocol
    
    init(historyManager: HistoryManagerProtocol) {
        self.historyManager = historyManager
    }
}

extension HistoryStorage: HistoryStorageProtocol {
    func create(historyEntity: HistoryEntity) {
        historyManager.create(historyEntity: historyEntity)
    }
    
    func read() -> BehaviorRelay<[HistoryEntity]> {
        return historyManager.read()
    }
}
