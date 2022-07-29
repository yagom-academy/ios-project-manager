//
//  EditViewModel.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/20.
//

import Foundation

final class EditViewModel: ViewModelType {
  @Published var task: Task
  
  init(withService: TaskManagementService, task: Task) {
    self.task = task
    super.init(withService: withService)
  }
  
  func doneButtonTapped() {
    self.service.update(task: task)
  }
}
