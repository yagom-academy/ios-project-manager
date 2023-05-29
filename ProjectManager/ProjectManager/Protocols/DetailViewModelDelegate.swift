//
//  TaskFetchDelegate.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/23.
//
import Foundation

protocol DetailViewModelDelegate: AnyObject {
    func createTask(_ task: Task)
    func updateTask(_ task: Task)
}
