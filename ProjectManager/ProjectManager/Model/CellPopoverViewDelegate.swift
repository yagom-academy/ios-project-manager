//
//  CellPopoverViewDelegate.swift
//  ProjectManager
//
//  Created by Mangdi on 2023/01/17.
//

import Foundation

protocol CellPopoverViewDelegate: AnyObject {
    func moveToTodo(from: CellPopoverViewMode, cellIndex: Int)
    func moveToDoing(from: CellPopoverViewMode, cellIndex: Int)
    func moveToDone(from: CellPopoverViewMode, cellIndex: Int)
}
