//
//  PopViewModel.swift
//  ProjectManager
//
//  Created by song on 2022/07/24.
//

import Foundation

class PopViewModel: ObservableObject {
  let todo: Todo
  let updata: (Status, Todo) -> Void
  
  init(todo: Todo, updata: @escaping (Status, Todo) -> Void) {
    self.todo = todo
    self.updata = updata
  }
}
