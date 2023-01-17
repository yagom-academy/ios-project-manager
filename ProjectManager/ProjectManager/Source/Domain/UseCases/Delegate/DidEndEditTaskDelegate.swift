//
//  DidEndEditTaskDelegate.swift
//  ProjectManager
//
//  Created by ayaan, jpush on 2023/01/17.
//

protocol DidEndCreateTaskDelegate: AnyObject {
    func didEndCreating(task: Task)
}

protocol DidEndUpdatingDelegate: AnyObject {
    func didEndUpdating(task: Task)
}

protocol DidEndDeletingDelegate: AnyObject {
    func didEndDeleting(task: Task)
}

protocol DidEndEditTask: DidEndEditTaskDelegate,
                         DidEndUpdatingDelegate,
                         DidEndDeletingDelegate { }
