//
//  DidEndEditingTaskDelegate.swift
//  ProjectManager
//
//  Created by ayaan, jpush on 2023/01/17.
//

protocol DidEndCreatingTaskDelegate: AnyObject {
    func didEndCreating(task: Task)
}

protocol DidEndUpdatingDelegate: AnyObject {
    func didEndUpdating(task: Task)
}

protocol DidEndEditingTaskDelegate: DidEndCreatingTaskDelegate,
                                    DidEndUpdatingDelegate { }
