//
//  TaskFetchDelegate.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/23.
//
import Foundation

protocol TaskFetchDelegate: AnyObject {
    func fetchTaskList()
    func updateTaskCell(workState: WorkState, itemID: UUID?) 
}
