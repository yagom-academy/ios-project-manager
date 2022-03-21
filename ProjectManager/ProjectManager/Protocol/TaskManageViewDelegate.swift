//
//  TaskManageViewDelegate.swift
//  ProjectManager
//
//  Created by 이차민 on 2022/03/15.
//

import Foundation

protocol TaskManageViewDelegate: AnyObject {
    func taskManageViewDidCreate(title: String, description: String, deadline: Date)
    func taskManageViewDidUpdate(at index: Int, title: String, description: String, deadline: Date, from state: TaskState)
}
