//
//  RegisterViewModel.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/20.
//

import SwiftUI

class RegisterViewModel: ViewModelType {
  @Published var title: String = ""
  @Published var body: String = ""
  @Published var date: Date = Date()
  
  func doneButtonTapped() {
    self.service.addTask(Task(title: title, date: date, body: body, type: .todo))
  }
}
