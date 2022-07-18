//
//  TodoListRepositoryMock.swift
//  ProjectManagerTests
//
//  Created by 조민호 on 2022/07/08.
//

import Combine
@testable import ProjectManager

final class FakeTodoListRepository: TodoListRepositorible {
    let storage: Storageable = FakeMemoryStorage()
    
    func create(_ item: Todo) {
        storage.create(item)
    }
    
    func read() -> AnyPublisher< [Todo], Never> {
        return storage.read()
    }
    
    func update(_ item: Todo) {
        storage.update(item)
    }
    
    func delete(item: Todo) {
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
