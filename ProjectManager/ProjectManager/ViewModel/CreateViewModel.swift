//
//  CreateViewModel.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/12.
//

import Foundation

class CreateViewModel: ObservableObject {
  var todoService: TodoService
  var create: (Todo) -> Void
  
  init(todoService: TodoService, create: @escaping (Todo) -> Void) {
    self.todoService = todoService
    self.create = create
  }
}
