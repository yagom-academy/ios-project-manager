//
//  FakeMemoryStorage.swift
//  ProjectManagerTests
//
//  Created by 조민호 on 2022/07/08.
//

import Combine
import Foundation
@testable import ProjectManager

final class FakeMemoryStorage: Storageable {
    @Published private var items: [Todo] = [
        Todo(title: "1", content: "1", deadLine: Date(), id: "1"),
        Todo(title: "2", content: "2", deadLine: Date(), id: "2"),
        Todo(title: "3", content: "3", deadLine: Date(), id: "3")
    ]
    
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
