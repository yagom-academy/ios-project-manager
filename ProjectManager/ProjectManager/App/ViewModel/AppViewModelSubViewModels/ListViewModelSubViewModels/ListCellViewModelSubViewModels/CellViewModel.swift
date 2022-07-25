//
//  TodoListCell.swift
//  ProjectManager
//
//  Created by song on 2022/07/24.
//

import Foundation

class CellViewModel: ObservableObject {
  @Published var todo: Todo
  @Published var isOverDate = false

  init(todo: Todo) {
    self.todo = todo
  }
  
  func confirmDate() {
    isOverDate = todo.date < Date() && todo.status != .done
  }
}
