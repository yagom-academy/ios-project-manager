//
//  TaskViewModel.swift
//  ProjectManager
//
//  Created by duckbok, Ryan-Son on 2021/07/20.
//

import Foundation

struct TaskViewModel {

    var added: ((_ index: Int) -> Void)?
    var changed: (() -> Void)?
    var inserted: ((_ state: Task.State, _ index: Int) -> Void)?
    var removed: ((_ state: Task.State, _ index: Int) -> Void)?

    private let repository = TaskRepository()

    private(set) var taskList = TaskList() {
        didSet {
            changed?()
        }
    }

    mutating func fetchTasks(completion: @escaping () -> Void) {
        repository.fetchTasks { result in
            switch result {
            case .success(let taskList):
                self.taskList = taskList
                completion()
            case .failure(let error):
                print(error)
                completion()
            }
        }
    }

    func task(from state: Task.State, at index: Int) -> Task? {
        let tasks: [Task] = taskList[state]
        guard index < tasks.count else { return nil }

        return tasks[index]
    }

    mutating func add(_ task: Task) {
        guard let index: Int = count(of: task.state) else { return }
        taskList[.todo].append(task)
        added?(index)
    }

    mutating func move(from sourceState: Task.State, at sourceIndex: Int,
                       to destinationState: Task.State, at destinationIndex: Int) {
        guard sourceState != destinationState,
              destinationIndex <= taskList[destinationState].count else { return }

        if let removedTask: Task = remove(state: sourceState, at: sourceIndex) {
            insert(removedTask, to: destinationState, at: destinationIndex)
        }
    }

    mutating func move(_ task: Task, to destinationState: Task.State, at destinationIndex: Int) {
        guard task.state != destinationState,
              destinationIndex <= taskList[destinationState].count else { return }

        if let removedTask: Task = remove(task) {
            insert(removedTask, to: destinationState, at: destinationIndex)
        }
    }

    mutating func move(in state: Task.State, from sourceIndex: Int, to destinationIndex: Int) {
        let tasks: [Task] = taskList[state]
        guard sourceIndex < tasks.count,
              destinationIndex < tasks.count else { return }

        let removedTask: Task = taskList[state].remove(at: sourceIndex)
        taskList[state].insert(removedTask, at: destinationIndex)
    }

    @discardableResult
    mutating func remove(state: Task.State, at index: Int) -> Task? {
        guard index < taskList[state].count else { return nil }

        let removedTask: Task = taskList[state].remove(at: index)
        removed?(state, index)
        return removedTask
    }

    @discardableResult
    mutating func remove(_ task: Task) -> Task? {
        let state: Task.State = task.state
        guard let index: Int = taskList[state].firstIndex(where: { $0.id == task.id }) else { return nil }

        let removedTask: Task = taskList[state].remove(at: index)
        removed?(state, index)
        return removedTask
    }

    private mutating func insert(_ task: Task, to state: Task.State, at index: Int) {
        guard index <= taskList[state].count else { return }

        taskList[state].insert(task, at: index)
        task.state = state
        inserted?(state, index)
    }

    func count(of state: Task.State) -> Int? {
        return taskList[state].count
    }
}
