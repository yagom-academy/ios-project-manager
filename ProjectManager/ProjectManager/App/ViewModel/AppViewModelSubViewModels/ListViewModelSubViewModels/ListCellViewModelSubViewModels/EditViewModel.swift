//
//  EditViewModel.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/12.
//

import Foundation

class EditViewModel: ObservableObject {
  var doneButtonTapped: (Todo) -> Void
  @Published var nonEditable: Bool
  @Published var todo: Todo
  
  init(todo: Todo, nonEditable: Bool = true, update: @escaping (Todo) -> Void) {
    self.doneButtonTapped = update
    self.todo = todo
    self.nonEditable = nonEditable
  }
  
  func editButtonTapped() {
    if nonEditable == true {
      nonEditable = false
    } else {
      doneButtonTapped(todo)
    }
  }
}
