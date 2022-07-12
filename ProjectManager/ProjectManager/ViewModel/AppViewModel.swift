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
    return todoService.todoList
  }
  
  func read(by status: Todo.Status) -> [Todo] {
    let filteredTodo = todoService.todoList.filter { todo in
      todo.status == status
    }
    return filteredTodo
  }
}
