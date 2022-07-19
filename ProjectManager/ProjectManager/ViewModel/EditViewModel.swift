//
//  EditViewModel.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/12.
//

import Foundation

class EditViewModel: ObservableObject {
  @Published var todoService: TodoService
  
  init(todoService: TodoService) {
    self.todoService = todoService
  }
  
  func update(todo: Todo) {
    todoService.update(todo: todo)
  }
}
