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
    self.tasks = service.allTasks
  }
  
  func cellTapped() {
    isShowingSheet.toggle()
  }
  
  func cellLongPressed() {
    isShowingPopover.toggle()
  }
  
  func moveTask(_ task: Task, type: TaskType) {
    self.service.move(task, type: type)
  }
  
  func readTasks() -> [Task] {
    self.service.readAllTasks().filter { $0.type == taskType }
  }
  
  func swipedCell(index: IndexSet) {
    index.forEach({ index in
      let taskToDelete = readTasks()[index]
      service.delete(task: taskToDelete)
    })
    self.tasks = service.allTasks
  }
}
