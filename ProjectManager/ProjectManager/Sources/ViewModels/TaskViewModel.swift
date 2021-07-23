//
//  TaskViewModel.swift
//  ProjectManager
//
//  Created by duckbok, Ryan-Son on 2021/07/20.
//

import Foundation

struct TaskViewModel {

    var added: (() -> Void)?
    var removed: ((Task.State, Int) -> Void)?
    var updated: ((Task.State, Int) -> Void)?
    var inserted: ((Task.State, Int) -> Void)?

    private let repository = TaskRepository()
    private(set) var taskOrder = TaskOrder()
    private var tasks: [Task] = []

    mutating func fetchTasks(completion: @escaping () -> Void) {
        repository.fetchTasks { result in
            switch result {
            case .success(let taskList):
                taskOrder = taskList.taskOrder
                tasks = taskList.tasks
                completion()
            case .failure(let error):
                print(error)
                completion()
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

    mutating func add(_ task: Task) {
        tasks.append(task)
        taskOrder.todo.append(task.id)
        added?()
    }

    mutating func remove(_ task: Task) {
        guard let index = taskOrder[task.state].firstIndex(of: task.id),
              let indexInTasks = tasks.firstIndex(where: { $0.id == task.id }) else { return }

        tasks.remove(at: indexInTasks)

        switch task.state {
        case .todo:
            taskOrder.todo.remove(at: index)
            removed?(.todo, index)
        case .doing:
            taskOrder.doing.remove(at: index)
            removed?(.doing, index)
        case .done:
            taskOrder.done.remove(at: index)
            removed?(.done, index)
        }
    }

    mutating func move(_ task: Task, to state: Task.State, at destinationIndex: Int) {
        remove(task)
        insert(task, to: state, at: destinationIndex)
    }

    mutating func update(_ newTask: Task) {
        guard let index = self.tasks.firstIndex(where: { $0.id == newTask.id }) else { return }
        tasks[index] = newTask

        switch newTask.state {
        case .todo:
            updated?(.todo, index)
        case .doing:
            updated?(.doing, index)
        case .done:
            updated?(.done, index)
        }
    }

    private mutating func insert(_ task: Task, to state: Task.State, at destinationIndex: Int) {
        let stateOrder: [UUID] = taskOrder[state]
        guard destinationIndex <= stateOrder.count else { return }

        tasks.append(task)

        switch state {
        case .todo:
            taskOrder.todo.insert(task.id, at: destinationIndex)
            inserted?(.todo, destinationIndex)
        case .doing:
            taskOrder.doing.insert(task.id, at: destinationIndex)
            inserted?(.doing, destinationIndex)
        case .done:
            taskOrder.done.insert(task.id, at: destinationIndex)
            inserted?(.done, destinationIndex)
        }

        tasks[destinationIndex].state = state
    }
}
