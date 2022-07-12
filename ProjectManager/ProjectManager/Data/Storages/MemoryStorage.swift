//
//  MemoryStorage.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/06.
//

import Foundation
import Combine

protocol Storageable {
    func create(_ item: TodoListModel)
    func read() -> AnyPublisher<[TodoListModel], Never>
    func update(_ item: TodoListModel)
    func delete(_ item: TodoListModel)
}

final class MemoryStorage: Storageable {
    @Published private var items: [TodoListModel] = TodoListModel.dummyData()
    
    func create(_ item: TodoListModel) {
        items.append(item)
    }
    
    func read() -> AnyPublisher<[TodoListModel], Never> {
        return $items.eraseToAnyPublisher()
    }
    
    func update(_ item: TodoListModel) {
        if let targetIndex = items.firstIndex(where: { $0.id == item.id }) {
            items[targetIndex] = item
        }
    }
    
    func delete(_ item: TodoListModel) {
        items.removeAll { $0.id == item.id }
    }
}
