//
//  TaskEditViewModel.swift
//  ProjectManager
//
//  Created by duckbok, Ryan-Son on 2021/07/26.
//

import Foundation

struct TaskEditViewModel {

    var updated: ((IndexPath, Task) -> Void)?
    var created: ((Task) -> Void)?

    private(set) var task: Task?
    private(set) var indexPath: IndexPath?
    private var taskCoreDataRepository: TaskCoreDataRepository

    init(coreDataStack: TaskCoreDataStackProtocol = TaskCoreDataStack.shared) {
        self.taskCoreDataRepository = TaskCoreDataRepository(coreDataStack: coreDataStack)
    }

    mutating func setTask(_ task: Task?, indexPath: IndexPath?) {
        self.task = task
        self.indexPath = indexPath
    }

    mutating func update(title: String, dueDate: Date, body: String) {
        guard let task = task,
              let indexPath = indexPath else { return }

        let isChanged: Bool = task.title != title || task.dueDate != dueDate || task.body != body
        guard isChanged else { return }

        taskCoreDataRepository.update(objectID: task.objectID, title: title, dueDate: dueDate, body: body)
        updated?(indexPath, task)
    }

    mutating func create(title: String, dueDate: Date, body: String) {
        guard let date = dueDate.date else { return }

        if let task = try? taskCoreDataRepository.create(title: title, body: body, dueDate: date, state: .todo) {
            self.task = task
            created?(task)
        }
    }
}
