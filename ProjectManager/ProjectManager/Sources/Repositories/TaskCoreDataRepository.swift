//
//  TaskCoreDataRepository.swift
//  ProjectManager
//
//  Created by duckbok, Ryan-Son on 2021/07/29.
//

import Foundation
import CoreData

struct TaskCoreDataRepository {

    var coreDataStack: TaskCoreDataStackProtocol

    var isEmpty: Bool {
        return coreDataStack.context.registeredObjects.count == 0
    }

    init(coreDataStack: TaskCoreDataStackProtocol = TaskCoreDataStack.shared) {
        self.coreDataStack = coreDataStack

        if readPendingTaskList() == nil {
            let context = coreDataStack.context
            let list = PendingTaskList(context: context)
            list.tasks = []

            self.coreDataStack.saveContext()
        }
    }

    private mutating func readPendingTaskList() -> PendingTaskList? {
        guard let pendingTaskList = coreDataStack.fetchPendingTaskList().first else { return nil }
        return pendingTaskList
    }

    func task(with objectID: NSManagedObjectID) -> Task? {
        return try? coreDataStack.context.existingObject(with: objectID) as? Task
    }

    mutating func create(title: String, body: String, dueDate: Date, state: Task.State) throws -> Task {
        let task = Task(context: coreDataStack.context, title: title, body: body, dueDate: dueDate, state: state)
        self.coreDataStack.saveContext()
        return task
    }

    mutating func read() -> TaskList {
        let tasks = coreDataStack.fetchTasks()
        let todos = tasks.filter { $0.taskState == .todo && !$0.isRemoved }
        let doings = tasks.filter { $0.taskState == .doing && !$0.isRemoved }
        let dones = tasks.filter { $0.taskState == .done && !$0.isRemoved }

        return TaskList(todos: todos, doings: doings, dones: dones)
    }

    mutating func update(objectID: NSManagedObjectID,
                         id: UUID? = nil,
                         title: String? = nil,
                         dueDate: Date? = nil,
                         body: String? = nil,
                         state: Task.State? = nil) {
        let context = coreDataStack.context
        guard let task = context.object(with: objectID) as? Task else { return }

        task.title = title ?? task.title
        task.body = body ?? task.body
        task.dueDate = dueDate ?? task.dueDate
        task.taskState = state ?? task.taskState

        self.coreDataStack.saveContext()
    }

    mutating func softDelete(_ id: NSManagedObjectID) {
        let context = coreDataStack.context
        guard let task = context.object(with: id) as? Task else { return }
        task.isRemoved = true

        self.coreDataStack.saveContext()
    }

    mutating func delete(_ id: NSManagedObjectID) {
        let context = coreDataStack.context
        guard let task = context.object(with: id) as? Task else { return }
        context.delete(task)

        self.coreDataStack.saveContext()
    }
}

extension TaskCoreDataRepository {

    mutating func readPendingTasks() -> [Task]? {
        guard let pendingTasks = readPendingTaskList()?.tasks?.array.compactMap({ $0 as? Task }) else { return nil }
        return pendingTasks
    }

    mutating func deleteFromPendingTaskList(_ task: Task) {
        readPendingTaskList()?.removeFromTasks(task)

        coreDataStack.saveContext()
    }

    mutating func insertFromPendingTaskList(_ task: Task) {
        readPendingTaskList()?.addToTasks(task)

        coreDataStack.saveContext()
    }
}
