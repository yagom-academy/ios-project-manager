//
//  CoreDataInterface.swift
//  ProjectManager
//
//  Created by 유한석 on 2022/09/23.
//

import CoreData

protocol CoreDataManagerInterface {
    func fetchAllTaskList() -> [ProjectTask]
    func fetchTaskList(state: ProjectTaskState) -> [ProjectTask]
    func saveCurrentTaskList()
    func saveTask(projectTask: ProjectTask, state: ProjectTaskState)
    func updateTask(projectTask: ProjectTask, state: ProjectTaskState)
    func deleteTask(id: UUID)
}
