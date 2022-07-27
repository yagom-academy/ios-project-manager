//
//  ListViewModel.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/20.
//

import Foundation

class ListViewModel: ViewModelType {
  @Published var isShowingSheet = false
  @Published var isShowingPopover = false
  @Published var tasks: [Task] = []
  @Published var taskType: TaskType = .todo
  
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
  
  func moveTask(_ task: Task, type: TaskType) {
    self.service.move(task, type: type)
    self.tasks = service.tasks
  }
  
  func readTasks() -> [Task] {
    self.service.read().filter { $0.type == taskType }
  }
  
  func swipedCell(index: IndexSet) {
    index.forEach({ index in
      let taskToDelete = readTasks()[index]
      service.delete(task: taskToDelete)
    })
    self.tasks = service.tasks
  }
}
