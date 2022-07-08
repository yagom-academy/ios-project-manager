//
//  MemoryStoregeMock.swift
//  ProjectManagerTests
//
//  Created by 조민호 on 2022/07/08.
//

import Combine
import Foundation
@testable import ProjectManager

final class MemoryStorageMock: Storage {
    @Published private var items: [TodoListModel] = [
        TodoListModel(title: "1", content: "1", deadLine: Date(), id: "1"),
        TodoListModel(title: "2", content: "2", deadLine: Date(), id: "2"),
        TodoListModel(title: "3", content: "3", deadLine: Date(), id: "3")
    ]
    
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
        if let targetIndex = items.firstIndex(where: { $0.id == item.id }) {
            items.remove(at: targetIndex)
        }
    }
}
