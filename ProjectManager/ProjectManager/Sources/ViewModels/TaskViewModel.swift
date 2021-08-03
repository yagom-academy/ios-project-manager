//
//  TaskViewModel.swift
//  ProjectManager
//
//  Created by duckbok, Ryan-Son on 2021/07/20.
//

import Foundation

final class TaskViewModel {

    var added: ((_ index: Int) -> Void)?
    var changed: (() -> Void)?
    var inserted: ((_ state: Task.State, _ index: Int) -> Void)?
    var removed: ((_ state: Task.State, _ index: Int) -> Void)?

    var networkStatusChanged: (() -> Void)?

    private let taskRepository = TaskRepository()
    private var taskManager = TaskManager()

    private(set) var taskList = TaskList() {
        didSet {
            changed?()
        }
    }

    /**
     지정한 state의 index에 해당하는 Task를 반환한다.

     - Parameter state: task가 위치한 상태 (todo, doing, done).
     - Parameter index: 상태에서 task가 위치한 index
     */
    func task(from state: Task.State, at index: Int) -> Task? {
        let tasks: [Task] = taskList[state]
        guard index < tasks.count else { return nil }

        return tasks[index]
    }

    /**
     지정한 Task를 todo state에 추가한다.

     - Parameter task: 추가할 task
     */
    func add(_ task: Task) {
        guard let index: Int = count(of: task.taskState) else { return }
        taskList[.todo].append(task)
        added?(index)
        post(task)
    }

    /**
     지정한 Task를 다른 state의 해당하는 index로 이동시킨다.

     - Parameter task: 이동할 task
     - Parameter destinationState: task의 이동할 상태
     - Parameter destinationIndex: 이동할 상태 내 task의 index
    */
    func move(_ task: Task, to destinationState: Task.State, at destinationIndex: Int) {
        guard task.taskState != destinationState,
              destinationIndex <= taskList[destinationState].count else { return }

        if remove(task) != nil {
            insert(task, to: destinationState, at: destinationIndex)
        }

        patch(task)
    }

    /**
    지정한 위치의 Task를 같은 state의 해당하는 index로 이동시킨다.

    - Parameter state: 이동할 task
    - Parameter sourceIndex: task의 기존 index
    - Parameter destinationIndex: task의 이동 후 index
    */
    func move(in state: Task.State, from sourceIndex: Int, to destinationIndex: Int) {
        let tasks: [Task] = taskList[state]
        guard sourceIndex < tasks.count,
              destinationIndex < tasks.count else { return }

        let removedTask: Task = taskList[state].remove(at: sourceIndex)
        taskList[state].insert(removedTask, at: destinationIndex)
    }

    /**
    변경된 Task를 서버에 갱신한다.

    - Parameter task: 변경된 Task
    */
    func update(_ task: Task) {
        patch(task)
    }

    /**
     지정한 위치의 Task를 삭제하고 이를 반환한다.

     - Parameter state: 삭제할 task가 위치한 상태
     - Parameter index: 삭제할 task의 상태 내 index
     */
    @discardableResult
    func remove(state: Task.State, at index: Int) -> String? {
        guard index < taskList[state].count else { return nil }

        let removedTitle: String = taskList[state][index].title
        let removedTask: Task = taskList[state].remove(at: index)
        taskManager.softDelete(removedTask.objectID)
        removed?(state, index)
        delete(removedTask)
        return removedTitle
    }

    /**
     지정한 Task를 삭제하고 이를 반환한다.

     - Parameter task: 삭제할 task
     */
    @discardableResult
    private func remove(_ task: Task) -> Task? {
        let state: Task.State = task.taskState
        guard let index: Int = taskList[state].firstIndex(where: { $0.id == task.id }) else { return nil }

        let removedTask: Task = taskList[state].remove(at: index)
        taskManager.delete(removedTask.objectID)
        removed?(state, index)
        return removedTask
    }

    /**
     지정한 Task를 지정한 state의 index에 삽입한다.

     - Parameter task: 삽입할 task
     - Parameter state: task를 삽입할 상태
     - Parameter index: 삽입할 상태 내 task의 index
     */
    private func insert(_ task: Task, to state: Task.State, at index: Int) {
        guard index <= taskList[state].count else { return }

        taskList[state].insert(task, at: index)
        taskManager.update(objectID: task.objectID, state: state)
        inserted?(state, index)
    }

    /**
     해당하는 state의 Task 개수를 반환한다.

     - Parameter state: task 개수를 알려줄 상태
     */
    func count(of state: Task.State) -> Int? {
        return taskList[state].count
    }

    // MARK: Networking

    private func post(_ task: Task) {
        taskRepository.post(task: task) { [weak self] result in
            switch result {
            case .success:
                self?.taskManager.deleteFromPendingTaskList(task)
            case .failure(let error):
                self?.taskManager.insertFromPendingTaskList(task)
                print(error)
            }
        }
    }

    private func patch(_ task: Task) {
        taskRepository.patch(task: task) { [weak self] result in
            switch result {
            case .success:
                print("Patch Succeed!")
                self?.taskManager.deleteFromPendingTaskList(task)
            case .failure(let error):
                self?.taskManager.insertFromPendingTaskList(task)
                print(error)
            }
        }
    }

    private func delete(_ removedTask: Task) {
        taskRepository.delete(task: removedTask) { [weak self] result in
            switch result {
            case .success(let id):
                self?.taskManager.delete(removedTask.objectID)
                self?.taskManager.deleteFromPendingTaskList(removedTask)
                print("Deletion succeed! ID: \(id)")
            case .failure(let error):
                self?.taskManager.insertFromPendingTaskList(removedTask)
                print(error)
            }
        }
    }

    func networkDidConnect() {
        taskRepository.fetchTasks { [weak self] result in
            guard let self = self else { return }
            defer { self.networkStatusChanged?() }
            switch result {
            case .success(let taskList):
                self.taskList = self.taskManager.isEmpty ? taskList : self.taskManager.read()
                self.taskManager.readPendingTasks()?.forEach { task in

                    let isCreated: Bool = !taskList.ids.contains(task.id) && !task.isRemoved
                    let isPatched: Bool = !isCreated && !task.isRemoved
                    let isDeleted: Bool = !isCreated && task.isRemoved

                    if isCreated {
                        self.post(task)
                    } else if isPatched {
                        self.patch(task)
                    } else if isDeleted {
                        self.delete(task)
                    }
                }
            case .failure(let error):
                self.taskList = self.taskManager.read()
                print(error)
            }
        }
    }

    func networkDidDisconnect() {
        taskList = self.taskManager.read()
        networkStatusChanged?()
    }
}
