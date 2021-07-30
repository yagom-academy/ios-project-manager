//
//  TaskDragCoordinator.swift
//  ProjectManager
//
//  Created by Fezravien on 2021/07/28.
//
import UIKit
import Foundation

final class TaskDragCoordinator {
    let sourceIndexPath: IndexPath
    let draggedCollectionView: UICollectionView
    
    init(sourceIndexPath: IndexPath, draggedCollectionView: UICollectionView) {
        self.sourceIndexPath = sourceIndexPath
        self.draggedCollectionView = draggedCollectionView
    }
}
