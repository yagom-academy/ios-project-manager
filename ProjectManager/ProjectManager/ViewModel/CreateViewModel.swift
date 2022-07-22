//
//  CreateViewModel.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/12.
//

import Foundation
import SwiftUI

class CreateViewModel: ObservableObject {
  var todoService: TodoService
  @Published var todo: Todo
  var isClosed: () -> Void
//  var create: (Todo) -> Void
  
  init(todoService: TodoService,
       todo: Todo = Todo(title: "", content: ""),
       isClosed: @escaping () -> Void
//       create: @escaping (Todo) -> Void
  ) {
    self.todoService = todoService
    self.todo = todo
    self.isClosed = isClosed
//    self.create = create
  }
  
  func cancelButtonTapped() {
    saveTodo()
    isClosed()
  }
  
  func doneButtonTapped() {
    saveTodo()
    isClosed()
  }
  
  private func saveTodo() {
    todoService.creat(todo: todo)
  }
}
