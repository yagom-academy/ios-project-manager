//
//  CreateViewModel.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/12.
//

import Foundation

class CreateViewModel: ObservableObject {
  @Published var todoService: TodoService
  
  init(todoService: TodoService) {
    self.todoService = todoService
  }
  
  func creat(todo: Todo) {
    todoService.todoList.insert(Todo(title: todo.title, content: todo.content, status: .todo), at: 0)
  }
}
