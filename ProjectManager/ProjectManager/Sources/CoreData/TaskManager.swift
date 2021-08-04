//
//  TaskManager.swift
//  ProjectManager
//
//  Created by duckbok, Ryan-Son on 2021/07/29.
//

import Foundation
import CoreData

struct TaskManager {

    var coreDataStack: CoreDataStack

    var isEmpty: Bool {
        return coreDataStack.context.registeredObjects.count == 0
    }

    init(coreDataStack: CoreDataStack = TaskCoreDataStack.shared) {
        self.coreDataStack = coreDataStack

        if readPendingTaskList() == nil {
            let context = coreDataStack.context
            let list = PendingTaskList(context: context)
            list.tasks = []

            do {
                try context.save()
            } catch {
                print(error)
            }
        }
    }

    private mutating func readPendingTaskList() -> PendingTaskList? {
        guard let pendingTaskList = coreDataStack.fetchPendingTaskList().first else { return nil }
        return pendingTaskList
    }

    func task(with objectID: NSManagedObjectID) -> Task? {
        return try? coreDataStack.context.existingObject(with: objectID) as? Task
    }

    func create(title: String, body: String, dueDate: Date, state: Task.State) throws -> Task {
        let context = coreDataStack.context
        let task = Task(context: context)

        task.id = UUID()
        task.title = title
        task.body = body
        task.dueDate = dueDate
        task.taskState = state

        do {
            try context.save()
        } catch {
            print(error)
        }

        return task
    }

    mutating func read() -> TaskList {
        let tasks = coreDataStack.fetchTasks()
        let todos = tasks.filter { $0.taskState == .todo && !$0.isRemoved }
        let doings = tasks.filter { $0.taskState == .doing && !$0.isRemoved }
        let dones = tasks.filter { $0.taskState == .done && !$0.isRemoved }

        return TaskList(todos: todos, doings: doings, dones: dones)
    }

    func update(objectID: NSManagedObjectID,
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

        do {
            try context.save()
        } catch {
            print(error)
        }
    }

    func softDelete(_ id: NSManagedObjectID) {
        let context = coreDataStack.context
        guard let task = context.object(with: id) as? Task else { return }
        task.isRemoved = true

        do {
            try context.save()
        } catch {
            print(error)
        }
    }

    func delete(_ id: NSManagedObjectID) {
        let context = coreDataStack.context
        guard let task = context.object(with: id) as? Task else { return }
        context.delete(task)

        do {
            try context.save()
        } catch {
            print(error)
        }
    }
}

extension TaskManager {

    mutating func readPendingTasks() -> [Task]? {
        guard let pendingTasks = readPendingTaskList()?.tasks?.array.compactMap({ $0 as? Task }) else { return nil }
        return pendingTasks
    }

    mutating func deleteFromPendingTaskList(_ task: Task) {
        let context = coreDataStack.context
        readPendingTaskList()?.removeFromTasks(task)

        do {
            try context.save()
        } catch {
            print(error)
        }
    }

    mutating func insertFromPendingTaskList(_ task: Task) {
        let context = coreDataStack.context
        readPendingTaskList()?.addToTasks(task)

        do {
            try context.save()
        } catch {
            print(error)
        }
    }
}
