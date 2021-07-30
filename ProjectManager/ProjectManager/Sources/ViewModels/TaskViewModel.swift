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

    private let taskRepository = TaskRepository()
    private let taskManager = TaskManager()

    private(set) var taskList = TaskList() {
        didSet {
            changed?()
        }
    }

    mutating func fetchTasks(completion: @escaping () -> Void) {
        taskRepository.fetchTasks { result in
            switch result {
            case .success(let taskList):
                self.taskList = taskList
                completion()
            case .failure(let error):
                print(error)
                self.taskList = taskManager.read()
                completion()
            }
        }
    }

    /// 지정한 state의 index에 해당하는 Task를 반환한다.
    func task(from state: Task.State, at index: Int) -> Task? {
        let tasks: [Task] = taskList[state]
        guard index < tasks.count else { return nil }

        return tasks[index]
    }

    /// 지정한 Task를 todo state에 추가한다.
    mutating func add(_ task: Task) {
        guard let index: Int = count(of: task.taskState) else { return }
        taskList[.todo].append(task)
        added?(index)
    }

    /// 지정한 Task를 다른 state의 해당하는 index로 이동시킨다.
    mutating func move(_ task: Task, to destinationState: Task.State, at destinationIndex: Int) {
        guard task.taskState != destinationState,
              destinationIndex <= taskList[destinationState].count else { return }

        if remove(task) != nil {
            insert(task, to: destinationState, at: destinationIndex)
        }
    }

    /// 지정한 위치의 Task를 같은 state의 해당하는 index로 이동시킨다.
    mutating func move(in state: Task.State, from sourceIndex: Int, to destinationIndex: Int) {
        let tasks: [Task] = taskList[state]
        guard sourceIndex < tasks.count,
              destinationIndex < tasks.count else { return }

        let removedTask: Task = taskList[state].remove(at: sourceIndex)
        taskList[state].insert(removedTask, at: destinationIndex)
    }

    /// 지정한 위치의 Task를 삭제하고 삭제한 Task의 제목을 반환한다.
    @discardableResult
    mutating func remove(state: Task.State, at index: Int) -> String? {
        guard index < taskList[state].count else { return nil }

        let removedTitle: String = taskList[state][index].title
        let removedTask: Task = taskList[state].remove(at: index)
        taskManager.delete(removedTask.objectID)
        removed?(state, index)
        return removedTitle
    }

    /// 지정한 Task를 삭제하고 이를 반환한다.
    @discardableResult
    mutating func remove(_ task: Task) -> Task? {
        let state: Task.State = task.taskState
        guard let index: Int = taskList[state].firstIndex(where: { $0.id == task.id }) else { return nil }

        let removedTask: Task = taskList[state].remove(at: index)
        taskManager.delete(removedTask.objectID)
        removed?(state, index)
        return removedTask
    }

    /// 지정한 Task를 지정한 state의 index에 삽입한다.
    private mutating func insert(_ task: Task, to state: Task.State, at index: Int) {
        guard index <= taskList[state].count else { return }

        taskList[state].insert(task, at: index)
        taskManager.update(id: task.objectID, state: state)
        inserted?(state, index)
    }

    /// 해당하는 state의 Task 개수를 반환한다.
    func count(of state: Task.State) -> Int? {
        return taskList[state].count
    }
}
