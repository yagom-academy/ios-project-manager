//
//  ListRowViewModel.swift
//  ProjectManager
//
//  Created by 김태훈 on 2022/07/29.
//

import Foundation

final class ListRowViewModel: ViewModelType {
  @Published var isShowingSheet: Bool = false
  @Published var isShowingPopover = false
  var task: Task
  
  init(withService: TaskManagementService, task: Task) {
    self.task = task
    super.init(withService: withService)
  }
  
  func cellTapped() {
    isShowingSheet.toggle()
  }
  
  func cellLongPressed() {
    isShowingPopover.toggle()
  }
  
  func moveButtonTapped(_ task: Task, type: TaskType) {
    self.service.move(task, type: type)
  }
}
