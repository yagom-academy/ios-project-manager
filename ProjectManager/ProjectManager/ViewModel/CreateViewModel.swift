//
//  CreateViewModel.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/12.
//

import Foundation

class CreateViewModel: ObservableObject {
  var create: (Todo) -> Void
  
  init(create: @escaping (Todo) -> Void) {
    self.create = create
  }
}
