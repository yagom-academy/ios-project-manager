//
//  DragSessionLocalContext.swift
//  ProjectManager
//
//  Created by 천수현 on 2021/07/26.
//

import Foundation

class DragSessionLocalContext {
    let sourceIndexPath: IndexPath
    var destinationIndexPath: IndexPath?
    var isReordering: Bool = false
    var didDragDropCompleted: Bool = false

    init(sourceIndexPath: IndexPath) {
        self.sourceIndexPath = sourceIndexPath
    }
}
