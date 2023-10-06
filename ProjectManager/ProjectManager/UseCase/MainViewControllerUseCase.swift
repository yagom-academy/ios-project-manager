//
//  MainViewControllerUseCase.swift
//  ProjectManager
//
//  Created by Karen, Zion on 2023/10/06.
//

import Foundation

protocol MainViewControllerUseCaseType {
    func convertUpdatedTaskList(taskList: [Task],
                                        updateTask: Task,
                                        moveTolistKind: ListKind?) -> [Task]
}

final class MainViewControllerUseCase: MainViewControllerUseCaseType {
    func convertUpdatedTaskList(taskList: [Task],
                                        updateTask: Task,
                                        moveTolistKind: ListKind? = nil) -> [Task] {
        return taskList.map {
            if $0.id == updateTask.id {
                var task = $0
                
                task.title = updateTask.title
                task.description = updateTask.description
                task.deadline = updateTask.deadline
                
                if let moveTolistKind = moveTolistKind {
                    task.listKind = moveTolistKind
                }
                
                return task
            }
            
            return $0
        }
    }
}
