//
//  DoneViewModel.swift
//  ProjectManager
//
//  Created by 최정민 on 2021/07/19.
//

import Foundation

struct DoneViewModel {
    private var taskList: [Task] = []
    
    func referTask(at: IndexPath) -> Task? {
        if taskList.count > at.row {
            return taskList[at.row]
        }
        return nil
    }
    
    func taskListCount() -> Int {
        return taskList.count
    }
    
    mutating func insertTaskIntoTaskList(index: Int, task: Task) {
        taskList.insert(task, at: index)
    }
}
