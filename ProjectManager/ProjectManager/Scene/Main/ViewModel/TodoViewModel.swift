//
//  TodoViewModel.swift
//  ProjectManager
//  Created by LIMGAUI on 2022/07/12

import Foundation
import Combine

final class TodoViewModel {
  
  private let storage: StorageType
  
  init(storage: StorageType) {
    self.storage = storage
  }
  // MARK: - Input

  func deleActionDidTap(_ todo: Todo) {
    storage.delete(todo)
  }
  //
  func popoverButtonDidTap(_ todo: Todo, to state: State) {
    let todo = Todo(
      id: todo.id,
      title: todo.title,
      content: todo.content,
      date: todo.date,
      state: state
    )
    
    storage.update(todo)
  }
  // MARK: - Output
  
  var toList: AnyPublisher<[Todo], Never> {
    return readData(by: .todo)
  }
  
  var doingList: AnyPublisher<[Todo], Never> {
    return readData(by: .doing)
  }
  
  var doneList: AnyPublisher<[Todo], Never> {
    return readData(by: .done)
  }
  
  private func readData(by state: State) -> AnyPublisher<[Todo], Never> {
    return storage.read().map { items in
      return items.filter { $0.state == state }
    }
    .eraseToAnyPublisher()
  }
}
