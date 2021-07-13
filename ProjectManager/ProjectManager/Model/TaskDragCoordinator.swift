//
//  TaskDragCoordinator.swift
//  ProjectManager
//
//  Created by James on 2021/07/13.
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
