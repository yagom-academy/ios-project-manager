//
//  TaskDragCoordinator.swift
//  ProjectManager
//
//  Created by sookim on 2021/07/27.
//

import Foundation

class TaskDragCoordinator {
  let sourceIndexPath: IndexPath
  var dragCompleted = false
  var isReordering = false

  init(sourceIndexPath: IndexPath) {
    self.sourceIndexPath = sourceIndexPath
  }
}
