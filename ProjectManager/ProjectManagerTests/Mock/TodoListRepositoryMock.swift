//
//  TodoListRepositoryMock.swift
//  ProjectManagerTests
//
//  Created by 조민호 on 2022/07/08.
//

import Combine
@testable import ProjectManager

final class TodoListRepositoryMock: TodoListRepository {
    let storage: Storage = MemoryStorageMock()
    
    func create(_ item: TodoListModel) {
        storage.create(item)
    }
    
    func read() -> AnyPublisher< [TodoListModel], Never> {
        return storage.read()
    }
    
    func update(_ item: TodoListModel) {
        storage.update(item)
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
