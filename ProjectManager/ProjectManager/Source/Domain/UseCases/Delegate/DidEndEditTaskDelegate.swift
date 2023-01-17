//
//  DidEndEditTaskDelegate.swift
//  ProjectManager
//
//  Created by ayaan, jpush on 2023/01/17.
//

import Foundation

protocol DidEndEditTaskDelegate: AnyObject {
    func didEndEdit(task: Task)
}
