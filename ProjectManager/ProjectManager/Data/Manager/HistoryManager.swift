//
//  HistoryManager.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/25.
//

import RxRelay

protocol HistoryManagerProtocol {
    func create(historyEntity: HistoryEntity)
    func read() -> BehaviorRelay<[HistoryEntity]>
}

final class HistoryManager {
    private var historyEntities = BehaviorRelay<[HistoryEntity]>(value: [])
}

extension HistoryManager: HistoryManagerProtocol {
    func create(historyEntity: HistoryEntity) {
        var currentProject = read().value
        
        currentProject.append(historyEntity)
        historyEntities.accept(currentProject)
    }
    
    func read() -> BehaviorRelay<[HistoryEntity]> {
        return historyEntities
    }
}
