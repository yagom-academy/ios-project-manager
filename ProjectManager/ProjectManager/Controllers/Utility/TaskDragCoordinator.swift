//
//  TaskDragCoordinator.swift
//  ProjectManager
//
//  Created by Fezravien on 2021/07/28.
//

import Foundation

final class TaskDragCoordinator {
    let sourceIndexPath: IndexPath
    var dragCompleted = false
    var isReordering = false
    
    init(sourceIndexPath: IndexPath) {
        self.sourceIndexPath = sourceIndexPath
    }
}
