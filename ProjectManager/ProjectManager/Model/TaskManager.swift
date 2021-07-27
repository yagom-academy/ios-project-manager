//
//  TaskManager.swift
//  ProjectManager
//
//  Created by 천수현 on 2021/07/20.
//

import UIKit
import CoreData

final class TaskManager {
    static let shared = TaskManager()
    weak var taskManagerDelegate: TaskManagerDelegate?

    let persistentContainer: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: "Task")
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
            }
        }
        return container
    }()

    lazy var viewContext = persistentContainer.viewContext
    var toDoTasks: [Task] = []
    var doingTasks: [Task] = []
    var doneTasks: [Task] = []

    private init() { }

    func createTask(title: String, description: String, date: Date) {
        viewContext.perform { [weak self] in
            guard let self = self else { return }
            let newTask = Task(context: self.viewContext)
            newTask.title = title
            newTask.body = description
            newTask.status = TaskStatus.TODO.rawValue
            newTask.date = date.timeIntervalSince1970

            self.toDoTasks.insert(newTask, at: 0)
            self.taskManagerDelegate?.taskDidCreated()
            self.saveTasks()
        }
    }

    func editTask(indexPath: IndexPath, title: String, description: String, date: Date, status: TaskStatus) {
        switch status {
        case .TODO:
            viewContext.perform { [weak self] in
                guard let self = self else { return }
                self.toDoTasks[indexPath.row].title = title
                self.toDoTasks[indexPath.row].body = description
                self.toDoTasks[indexPath.row].date = date.timeIntervalSince1970
                self.taskManagerDelegate?.taskDidEdited(indexPath: indexPath, status: .TODO)
                self.saveTasks()
            }
        case .DOING:
            viewContext.perform { [weak self] in
                guard let self = self else { return }
                self.doingTasks[indexPath.row].title = title
                self.doingTasks[indexPath.row].body = description
                self.doingTasks[indexPath.row].date = date.timeIntervalSince1970
                self.taskManagerDelegate?.taskDidEdited(indexPath: indexPath, status: .DOING)
                self.saveTasks()
            }
        case .DONE:
            viewContext.perform { [weak self] in
                guard let self = self else { return }
                self.doneTasks[indexPath.row].title = title
                self.doneTasks[indexPath.row].body = description
                self.doneTasks[indexPath.row].date = date.timeIntervalSince1970
                self.taskManagerDelegate?.taskDidEdited(indexPath: indexPath, status: .DONE)
                self.saveTasks()
            }
        }
    }

    func deleteTask(indexPath: IndexPath, status: TaskStatus) {
        switch status {
        case .TODO:
            viewContext.perform { [weak self] in
                guard let self = self else { return }
                self.viewContext.delete(self.toDoTasks[indexPath.row])
                self.toDoTasks.remove(at: indexPath.row)
                self.taskManagerDelegate?.taskDidDeleted(indexPath: indexPath, status: .TODO)
                self.saveTasks()
            }
        case .DOING:
            viewContext.perform { [weak self] in
                guard let self = self else { return }
                self.viewContext.delete(self.doingTasks[indexPath.row])
                self.doingTasks.remove(at: indexPath.row)
                self.taskManagerDelegate?.taskDidDeleted(indexPath: indexPath, status: .DOING)
                self.saveTasks()
            }
        case .DONE:
            viewContext.perform { [weak self] in
                guard let self = self else { return }
                self.viewContext.delete(self.doneTasks[indexPath.row])
                self.doneTasks.remove(at: indexPath.row)
                self.taskManagerDelegate?.taskDidDeleted(indexPath: indexPath, status: .DONE)
                self.saveTasks()
            }
        }
    }

    func fetchTasks() throws {
        let request = Task.fetchRequest() as NSFetchRequest<Task>
        let tasks = try viewContext.fetch(request)

        self.toDoTasks = tasks.filter { $0.status == "TODO" }
        self.doingTasks = tasks.filter { $0.status == "DOING" }
        self.doneTasks = tasks.filter { $0.status == "DONE" }
    }

    func saveTasks() {
        do {
            try self.viewContext.save()
        } catch {

        }
    }
}
