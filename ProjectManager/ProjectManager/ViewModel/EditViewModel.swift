//
//  EditViewModel.swift
//  ProjectManager
//
//  Created by LIMGAUI on 2022/07/15.
//

import Foundation

final class EditViewModel: NSObject {
  let todo: Todo
  
  init(todo: Todo) {
    self.todo = todo
  }
}
