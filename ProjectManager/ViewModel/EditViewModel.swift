//
//  EditViewModel.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/20.
//

import SwiftUI

class EditViewModel: ViewModelType {
  @Published var title: String = ""
  @Published var body: String = ""
  @Published var date: Date = Date()
  var task: Task = Task(title: "", date: Date(), body: "", type: .todo)
  
  init(withService: TaskManagementService, task: Task) {
    super.init(withService: withService)
    self.task = task
  }
  
  func doneButtonTapped() {
    self.service.update(task: task)
  }
}
