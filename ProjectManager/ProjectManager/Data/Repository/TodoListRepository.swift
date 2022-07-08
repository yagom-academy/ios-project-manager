//
//  TodoListRepository.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/06.
//

import Foundation
import Combine

final class TodoListRepository {
    private let storage: Storage
    
    init(storage: Storage) {
        self.storage = storage
    }
}

extension TodoListRepository: Repository {
    func create(_ item: TodoListModel) {
        storage.create(item)
    }
    
    func read() -> AnyPublisher< [TodoListModel], Never> {
        return storage.read()
    }
    
    func delete(item: TodoListModel) {
        storage.delete(item)
    }
    
    func deleteLastItem() {
        _ = storage.read()
            .prefix(1)
            .sink { [weak self] items in
            guard let lastItem = items.last else { return }
            self?.storage.delete(lastItem)
        }
    }
}
