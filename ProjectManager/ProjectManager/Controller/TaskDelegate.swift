//
//  TaskDelegate.swift
//  ProjectManager
//
//  Created by 배은서 on 2021/07/29.
//

import Foundation

protocol TaskDelegate: AnyObject {
    func sendTask(_ taskAlertViewController: TaskAlertViewController, task: Task)
}
