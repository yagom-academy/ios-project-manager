//
//  MemoryStorage.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/06.
//

import Foundation
import Combine

protocol Storageable: AnyObject {
    func create(_ item: Todo)
    func read() -> AnyPublisher<[Todo], Never>
    func update(_ item: Todo)
    func delete(_ item: Todo)
}

final class MemoryStorage: Storageable {
    @Published private var items: [Todo] = Todo.dummyData()
    
    func create(_ item: Todo) {
        items.append(item)
    }
    
    func read() -> AnyPublisher<[Todo], Never> {
        return $items.eraseToAnyPublisher()
    }
    
    func update(_ item: Todo) {
        if let targetIndex = items.firstIndex(where: { $0.id == item.id }) {
            items[targetIndex] = item
        }
    }
    
    func delete(_ item: Todo) {
        items.removeAll { $0.id == item.id }
    }
}
