//
//  TaskManageViewDelegate.swift
//  ProjectManager
//
//  Created by 이차민 on 2022/03/15.
//

import Foundation

protocol TaskManageViewDelegate: AnyObject {
    func taskManageViewDidCreate(with task: Task)
    func taskManageViewDidUpdate(at index: Int, with task: Task)
}
