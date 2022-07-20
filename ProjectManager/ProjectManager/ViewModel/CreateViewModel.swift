//
//  CreateViewModel.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/12.
//

import Foundation

class CreateViewModel: ObservableObject {
  var todoService: TodoService
  @Published var todoList: [Todo]
  
  init(todoService: TodoService, todoList: [Todo]) {
    self.todoService = todoService
    self.todoList = todoList
  }
  
  func creat(todo: Todo) {
    todoService.creat(todo: todo)
    todoList = todoService.read()
  }
}
