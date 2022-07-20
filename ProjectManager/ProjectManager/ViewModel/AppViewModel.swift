//
//  AppViewModel.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/06.
//

import Foundation
import SwiftUI

class AppViewModel: ObservableObject {
  var todoService: TodoService = TodoService()
  @Published private var todoList: [Todo] = []
  
  lazy var listViewModel = ListViewModel(todoService: todoService, todoList: todoList)
  lazy var createViewModel = CreateViewModel(todoService: todoService, todoList: todoList)
  
  init(todoService: TodoService) {
    self.todoService = todoService
    todoList = todoService.read()
  }
  
  private func create(todo: Todo) {
    todoService.creat(todo: todo)
    todoList = todoService.read()
  }
  
//  func read() -> [Todo] {
//    return todoService.read()
//  }
//
//  func read(by status: Status) -> [Todo] {
//    todoService.read(by: status)
//  }
  
  func changeStatus(status: Status, todo: Todo) {
    let updateTodo = Todo(id: todo.id, title: todo.title, content: todo.content, date: todo.date, status: status)
    todoService.update(todo: updateTodo)
  }
}
