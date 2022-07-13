//
//  AppViewModel.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/06.
//

import Foundation

class AppViewModel: ObservableObject {
  @Published var todoService: TodoService
  
  init(todoService: TodoService) {
    self.todoService = todoService
  }
  
  func read() -> [Todo] {
    return todoService.read()
  }
  
  func read(by status: Todo.Status) -> [Todo] {
    todoService.read(by: status)
  }
  
  func changeStatus(status: Todo.Status, todo: Todo) {
    todo.status = status
  }
}
