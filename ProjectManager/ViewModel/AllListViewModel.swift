//
//  AllListViewModel.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/20.
//

import Foundation

class AllListViewModel: ViewModelType {
}

class ListViewModel: ViewModelType {
  @Published var isShowingSheet = false
  @Published var isShowingPopover = false
  var taskType = TaskType.todo
  
  init(withService: TaskManagementService, taskType: TaskType) {
    super.init(withService: withService)
    self.taskType = taskType
  }
  
  func toggleShowingSheet() {
    isShowingSheet.toggle()
  }
  
  func toggleShowingPopover() {
    isShowingPopover.toggle()
  }
  
  func moveTask(_ task: Task, to: TaskType) {
    self.service.moveTask(task, to: to)
  }
  
  func readTasks() -> [Task] {
    self.service.readTasks().filter { $0.type == taskType }
  }
}
