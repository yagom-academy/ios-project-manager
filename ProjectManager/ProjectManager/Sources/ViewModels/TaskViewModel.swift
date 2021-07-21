//
//  TaskViewModel.swift
//  ProjectManager
//
//  Created by duckbok, Ryan-Son on 2021/07/20.
//

import Foundation

struct TaskViewModel {

    private let repository = TaskRepository()
    private var taskOrder = TaskOrder()
    private var tasks: [Task] = []

    mutating func fetchTasks() {
        repository.fetchTasks { result in
            switch result {
            case .success(let taskList):
                taskOrder = taskList.taskOrder
                tasks = taskList.tasks
            case .failure(let error):
                print(error)
            }
        }
    }

    func task(from state: Task.State, at index: Int) -> Task? {
        let stateOrder: [UUID] = taskOrder[state]
        guard index < stateOrder.count else { return nil }
        let taskID = stateOrder[index]

        return task(by: taskID)
    }

    private func task(by id: UUID) -> Task? {
        return tasks.filter { $0.id == id }.first
    }
}
