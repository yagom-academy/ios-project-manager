//
//  TaskEditViewControllerDelegate.swift
//  ProjectManager
//
//  Created by duckbok, Ryan-Son on 2021/07/26.
//

import UIKit

protocol TaskEditViewControllerDelegate: AnyObject {
    func taskWillUpdate(_ task: Task, _ indexPath: IndexPath)
    func taskWillAdd(_ task: Task)
}
