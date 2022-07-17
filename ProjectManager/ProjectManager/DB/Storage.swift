//
//  Storage.swift
//  ProjectManager
//
//  Created by LIMGAUI on 2022/07/17.
//

import Foundation
import Combine

protocol StorageType {
  func create(_ todo: Todo)
  func read() -> AnyPublisher<[Todo], Never>
  func update(_ todo: Todo)
  func delete(_ todo: Todo)
}

final class MemoryStorage: StorageType {
  static let shared = MemoryStorage()
  private init() {}
  
  @Published private var items = Todo.dummy
  
  func create(_ todo: Todo) {
    items.append(todo)
  }
  
  func read() -> AnyPublisher<[Todo], Never> {
    return $items.eraseToAnyPublisher()
  }
  
  func update(_ todo: Todo) {
    guard let index = items.firstIndex(where: { $0.id == todo.id }) else {
      return
    }
  
    items[index] = todo
  }
  
  func delete(_ todo: Todo) {
    items.removeAll(where: { $0.id == todo.id })
  }
}
