//
//  TodoListCell.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/24.
//

import Foundation

class CellContentViewModel: ObservableObject {
  @Published var todo: Todo
  
  var isOverDate: Bool {
    return todo.date < Date() && todo.status != .done
  }

  init(todo: Todo) {
    self.todo = todo
  }
}
