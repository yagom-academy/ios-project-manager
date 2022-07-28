//
//  TodoHistoryRepository.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/19.
//

import Foundation
import Combine

final class TodoHistoryRepository {
    private unowned let storage: HistoryStorageable
    
    init(storage: HistoryStorageable) {
        self.storage = storage
    }
}

extension TodoHistoryRepository: TodoHistoryRepositorible {
    func create(_ item: TodoHistory) {
        storage.create(item)
    }
    
    var todoHistoriesPublisher: CurrentValueSubject<HistoryStorageState, Never> {
        return storage.todoHistoriesPublisher
    }
    
    func delete(item: TodoHistory) {
        storage.delete(item)
    }
}
