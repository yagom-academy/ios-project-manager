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
  lazy var createViewModel = CreateViewModel(todoService: todoService) { [self] todo in
    self.todoService.creat(todo: todo)
    todoList = todoService.read()
//    todoList.append(todo)
  }
  
  init(todoService: TodoService) {
    self.todoService = todoService
    todoList = todoService.read()
  }
  
  func changeStatus(status: Status, todo: Todo) {
    let updateTodo = Todo(id: todo.id, title: todo.title, content: todo.content, date: todo.date, status: status)
    todoService.update(todo: updateTodo)
    
    todoList = todoService.read()
//    guard let index = todoList.firstIndex(where: { $0.id == todo.id }) else { return }
//    todoList[index].status = todo.status
  }
}
