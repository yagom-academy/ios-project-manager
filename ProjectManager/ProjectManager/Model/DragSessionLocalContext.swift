//
//  DragSessionLocalContext.swift
//  ProjectManager
//
//  Created by 천수현 on 2021/07/26.
//

import Foundation

class DragSessionLocalContext {
    let originIndexPath: IndexPath
    var destinationIndexPath: IndexPath?
    var isReordering: Bool = false
    var didDragDropCompleted: Bool = false

    init(originIndexPath: IndexPath) {
        self.originIndexPath = originIndexPath
    }
}
