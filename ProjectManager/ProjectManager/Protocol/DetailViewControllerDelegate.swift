//
//  TaskFetchDelegate.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/23.
//
import Foundation

protocol DetailViewControllerDelegate: AnyObject {
    func configureDataSource()
    func updateDataSource(for workState: WorkState, itemID: UUID?)
}
