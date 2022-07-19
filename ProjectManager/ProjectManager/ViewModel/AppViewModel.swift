//
//  AppViewModel.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/06.
//

import Foundation

class AppViewModel: ObservableObject {
  @Published var todoService: TodoService = TodoService()
  
  lazy var listViewModel = ListViewModel(todoService: todoService)
  lazy var createViewModel = CreateViewModel(todoService: todoService)
  
  init(todoService: TodoService) {
    self.todoService = todoService
  }
  
  private func create(todo: Todo) {
    todoService.creat(todo: todo)
  }
  
  func read() -> [Todo] {
    return todoService.read()
  }
  
  func read(by status: Todo.Status) -> [Todo] {
    todoService.read(by: status)
  }
  
  func changeStatus(status: Todo.Status, todo: Todo) {
    let updateTodo = Todo(id: todo.id, title: todo.title, content: todo.content, date: todo.date, status: status)
    todoService.update(todo: updateTodo)
  }
}
