//
//  CreateViewModel.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/12.
//

import Foundation
import SwiftUI

class CreateViewModel: ObservableObject {
  let todoService: TodoService
  var todo: Todo
  var close: () -> Void
  @Published var todoList: [Todo]

  
  init(todoService: TodoService,
       todo: Todo = Todo(title: "", content: ""),
       todoList: [Todo],
       close: @escaping () -> Void) {
    self.todoService = todoService
    self.todo = todo
    self.todoList = todoList
    self.close = close
  }
  
  func cancelButtonTapped() {
    close()
   }
  
  func doneButtonTapped() {
    saveTodo()
    close()
  }
  
  private func saveTodo() {
    todoService.creat(todo: todo)
    todoList = todoService.read()
  }
}
