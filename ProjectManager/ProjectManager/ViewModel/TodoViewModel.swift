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
  
  // plus button did tap
  // cell did swipe delete
  func deleActionDidTap(_ todo: Todo) {
    storage.delete(todo)
  }
  //
  // MARK: - Output
  
  var toList: AnyPublisher<[Todo], Never> {
    return storage.read()
      .map { items in
        return items.filter { $0.state == .todo }
      }
      .eraseToAnyPublisher()
  }
  
  var doingList: AnyPublisher<[Todo], Never> {
    return storage.read()
      .map { items in
        return items.filter { $0.state == .doing }
      }
      .eraseToAnyPublisher()
  }
  
  var doneList: AnyPublisher<[Todo], Never> {
    return storage.read()
      .map { items in
        return items.filter { $0.state == .done }
      }
      .eraseToAnyPublisher()
  }
  
//  func append(_ todo: Todo) {
//    items.append(todo)
//  }
//
//  func update(by index: Int, todo: Todo) {
//    items[index] = todo
//  }
//
//  func update(to state: State, by index: Int) {
//    items[index].state = state
//  }
//
//  func findListCount(_ todoState: State) -> Int {
//    return items.filter { $0.state == todoState }.count
//  }
//
//  func filterList(by state: State) -> [Todo] {
//    return items.filter { $0.state == state }
//  }
}
