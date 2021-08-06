//
//  CoreDataRepository.swift
//  ProjectManager
//
//  Created by duckbok, Ryan-Son on 2021/07/29.
//

import Foundation
import CoreData

struct CoreDataRepository {

    var coreDataStack: CoreDataStackProtocol

    init(coreDataStack: CoreDataStackProtocol = CoreDataStack.shared) {
        self.coreDataStack = coreDataStack

        if pendingTaskList() == nil {
            let list = PendingTaskList(context: self.coreDataStack.context)
            list.tasks = []

            self.coreDataStack.saveContext()
        }
    }
}

// MARK: - Task

extension CoreDataRepository {

    var isEmpty: Bool {
        return coreDataStack.context.registeredObjects.count == 0
    }

    func task(with objectID: NSManagedObjectID) -> Task? {
        return try? coreDataStack.context.existingObject(with: objectID) as? Task
    }

    mutating func create(title: String, body: String? = nil, dueDate: Date, state: Task.State) throws -> Task {
        let task = Task(context: coreDataStack.context, title: title, body: body, dueDate: dueDate, state: state)
        coreDataStack.saveContext()
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
        guard let task = coreDataStack.context.object(with: objectID) as? Task else { return }

        task.title = title ?? task.title
        task.dueDate = dueDate ?? task.dueDate
        task.taskState = state ?? task.taskState

        if let body = body {
            task.body = body.isEmpty ? nil : body
        }

        coreDataStack.saveContext()
    }

    mutating func softDelete(_ id: NSManagedObjectID) {
        guard let task = coreDataStack.context.object(with: id) as? Task else { return }
        task.isRemoved = true

        self.coreDataStack.saveContext()
    }

    mutating func delete(_ id: NSManagedObjectID) {
        guard let task = coreDataStack.context.object(with: id) as? Task else { return }
        coreDataStack.context.delete(task)

        coreDataStack.saveContext()
    }
}

// MARK: - PendingTaskList

extension CoreDataRepository {

    mutating func readPendingTasks() -> [Task]? {
        guard let pendingTasks = pendingTaskList()?.tasks?.array.compactMap({ $0 as? Task }) else { return nil }
        return pendingTasks
    }

    mutating func insertFromPendingTaskList(_ task: Task) {
        pendingTaskList()?.addToTasks(task)

        coreDataStack.saveContext()
    }

    mutating func deleteFromPendingTaskList(_ task: Task) {
        pendingTaskList()?.removeFromTasks(task)

        coreDataStack.saveContext()
    }

    private mutating func pendingTaskList() -> PendingTaskList? {
        guard let pendingTaskList = coreDataStack.fetchPendingTaskList().first else { return nil }
        return pendingTaskList
    }
}
