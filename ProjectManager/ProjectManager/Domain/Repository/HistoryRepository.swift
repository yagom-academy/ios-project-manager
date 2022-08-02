//
//  HistoryRepository.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/26.
//

import RxRelay

protocol HistoryRepositoryProtocol {
    func create(historyEntity: HistoryEntity)
    func read() -> BehaviorRelay<[HistoryEntity]>
}

struct HistoryRepository: HistoryRepositoryProtocol {
    private let historyManager: HistoryManagerProtocol
    
    init(historyManager: HistoryManagerProtocol) {
        self.historyManager = historyManager
    }
}

extension HistoryRepository {
    func create(historyEntity: HistoryEntity) {
        historyManager.create(historyEntity: historyEntity)
    }
    
    func read() -> BehaviorRelay<[HistoryEntity]> {
        return historyManager.read()
    }
}
