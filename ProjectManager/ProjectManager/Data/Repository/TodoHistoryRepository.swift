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
    func create(_ item: TodoHistory) -> AnyPublisher<Void, StorageError> {
        return storage.create(item)
    }
    
    func read() -> CurrentValueSubject<[TodoHistory], Never> {
        return storage.read()
    }
    
    func update(_ item: TodoHistory) -> AnyPublisher<Void, StorageError> {
        return storage.update(item)
    }
    
    func delete(item: TodoHistory) -> AnyPublisher<Void, StorageError> {
        return storage.delete(item)
    }
}
