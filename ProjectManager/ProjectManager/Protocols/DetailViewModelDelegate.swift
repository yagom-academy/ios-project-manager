//
//  TaskFetchDelegate.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/23.
//
import Foundation

protocol DetailViewModelDelegate: AnyObject {
    func updateTaskList(for workState: WorkState)
    func updateDataSource(for workState: WorkState, itemID: UUID?)
}
