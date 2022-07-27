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
  
  func moveTask(_ task: Task, type: TaskType) {
    self.service.move(task, type: type)
  }
  
  func readTasks() -> [Task] {
    self.service.read().filter { $0.type == taskType }
  }
  
  func swipedCell(index: IndexSet) {
    let tasks = service.read()
    let filterTasks = tasks.filter({ $0.type == taskType })
    let taskToDelete = filterTasks[index.first ?? 0]
    
    service.delete(task: taskToDelete)
  }
}
