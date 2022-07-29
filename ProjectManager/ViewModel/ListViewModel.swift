//
//  ListViewModel.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/20.
//

import Foundation

final class ListViewModel: ViewModelType {
  @Published var filteredTasks: [Task] = []
  @Published var taskType: TaskType = .todo
  
  init(withService: TaskManagementService, taskType: TaskType) {
    super.init(withService: withService)
    self.taskType = taskType
    self.filteredTasks = service.allTasks.filter({ $0.type == taskType })
  }
  
  func deleteCell(index: IndexSet) {
    index.forEach({ index in
      let taskToDelete = filteredTasks[index]
      service.delete(task: taskToDelete)
    })
    self.filteredTasks = service.allTasks.filter({ $0.type == taskType })
  }
}
