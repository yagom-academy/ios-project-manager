//
//  TaskManageDelegate.swift
//  ProjectManager
//
//  Created by 이차민 on 2022/03/15.
//

import Foundation

protocol TaskManageDelegate: AnyObject {
    func create(title: String, description: String, deadline: Date)
    func update(at index: Int, title: String, description: String, deadline: Date, from state: TaskState)
}
