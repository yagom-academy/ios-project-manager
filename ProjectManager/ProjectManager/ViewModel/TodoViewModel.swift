//
//  TodoViewModel.swift
//  ProjectManager
//  Created by LIMGAUI on 2022/07/12

import Foundation

final class TodoViewModel {
  private var items: [Todo] = []
  
  init() {
    DispatchQueue.main.asyncAfter(wallDeadline: .now()+1) {
      self.items.append(contentsOf: Todo.dummy)
    }
  }

  var toList: [Todo] {
    return filterList(by: .todo)
  }
  
  var doingList: [Todo] {
    return filterList(by: .doing)
  }
  
  var doneList: [Todo] {
    return filterList(by: .done)
  }
  
  func append(_ todo: Todo) {
    items.append(todo)
  }
  
  func update(by index: Int, todo: Todo) {
    items[index] = todo
  }
  
  func update(to state: State, by index: Int) {
    items[index].state = state
  }
  
  func findListCount(_ todoState: State) -> Int {
    return items.filter { $0.state == todoState }.count
  }
  
  func filterList(by state: State) -> [Todo] {
    return items.filter { $0.state == state }
  }
}
