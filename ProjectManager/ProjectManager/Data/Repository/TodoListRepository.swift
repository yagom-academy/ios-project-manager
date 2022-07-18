//
//  DefaultTodoListRepository.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/06.
//

import Foundation
import Combine

final class TodoListRepository {
    private unowned let storage: Storageable
    
    var bag = Set<AnyCancellable>()
    
    init(storage: Storageable) {
        self.storage = storage
    }
}

extension TodoListRepository: TodoListRepositorible {
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
