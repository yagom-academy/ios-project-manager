//
//  File.swift
//  ProjectManager
//
//  Created by 기원우 on 2021/08/05.
//

import Foundation

final class DragSessionLocalContext {
    let originIndexPath: IndexPath
    var destinationIndexPath: IndexPath?
    var isReordering: Bool = false
    var didDragDropCompleted: Bool = false

    init(originIndexPath: IndexPath) {
        self.originIndexPath = originIndexPath
    }
}
