//
//  ViewModelType.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/21.
//

import Foundation

class ViewModelType: ObservableObject {
  var service: TaskManagementService
  
  init(withService: TaskManagementService) {
    self.service = withService
  }
}
