//
//  HistoryRepository.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/26.
//

import RxRelay

protocol HistoryRepositoryProtocol {
    var historyStorage: HistoryStorageProtocol { get }
    func create(historyEntity: HistoryEntity)
    func read() -> BehaviorRelay<[HistoryEntity]>
}

struct HistoryRepository: HistoryRepositoryProtocol {
    let historyStorage: HistoryStorageProtocol
    
    init(historyStorage: HistoryStorageProtocol) {
        self.historyStorage = historyStorage
    }
}

extension HistoryRepository {
    func create(historyEntity: HistoryEntity) {
        historyStorage.create(historyEntity: historyEntity)
    }
    
    func read() -> BehaviorRelay<[HistoryEntity]> {
        return historyStorage.read()
    }
}
