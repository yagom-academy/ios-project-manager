//
//  EditViewModel.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/12.
//

import Foundation

class EditViewModel: ObservableObject {
  var update: (Todo) -> Void
  @Published var nonEditable: Bool
  @Published var todo: Todo
  
  init(todo: Todo, nonEditable: Bool = true, update: @escaping (Todo) -> Void) {
    self.update = update
    self.todo = todo
    self.nonEditable = nonEditable
  }
}
