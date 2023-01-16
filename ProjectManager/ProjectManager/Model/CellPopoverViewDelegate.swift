//
//  CellPopoverViewDelegate.swift
//  ProjectManager
//
//  Created by Mangdi on 2023/01/17.
//

import Foundation

protocol CellPopoverViewDelegate: AnyObject {
    func moveToTodo()
    func moveToDoing()
    func moveToDone()
}
