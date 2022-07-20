//
//  EditViewModel.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/12.
//

import Foundation

class EditViewModel: ObservableObject {
  @Published var todoService: TodoService
  var update: (Todo) -> Void
  
  init(todoService: TodoService, update: @escaping (Todo) -> Void) {
    self.todoService = todoService
    self.update = update
  }
//  func update(todo: Todo) {
//    todoService.update(todo: todo)
//  }
}
