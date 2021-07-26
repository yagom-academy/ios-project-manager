//
//  CacheDragCoordinator.swift
//  ProjectManager
//
//  Created by 이영우 on 2021/07/22.
//

import Foundation

class DragCoordinator {
    var isReordering: Bool = false
    var dragCompleted: Bool = false
    let indexPath: IndexPath
    
    init(indexPath: IndexPath) {
        self.indexPath = indexPath
    }
}
