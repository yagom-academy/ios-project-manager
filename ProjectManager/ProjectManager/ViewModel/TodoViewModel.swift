//
//  TodoViewModel.swift
//  ProjectManager
//  Created by LIMGAUI on 2022/07/12

import Foundation

final class TodoViewModel: NSObject {
  private let todo = Todo()
  private var todoList: [Todo]
  
  override init() {
    todoList = todo.readList
  }
  
  var readList: [Todo] {
    return todoList
  }
  
  func append(_ todo: Todo) {
    todoList.append(todo)
  }
  
  func update(by index: Int, todo: Todo) {
    todoList[index] = todo
  }
  
  func update(to state: State, by index: Int) {
    todoList[index].state = state
  }
  
  func findListCount(_ todoState: State) -> Int {
    return todoList.filter { $0.state == todoState }.count
  }
  
  func filterList(by state: State) -> [Todo] {
    return todoList.filter { $0.state == state }
  }
}
