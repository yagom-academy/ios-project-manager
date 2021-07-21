//
//  TaskManager.swift
//  ProjectManager
//
//  Created by 천수현 on 2021/07/20.
//

import Foundation
import CoreData

/*
 서버에 저장된 데이터(특정 시점을 잡아서 데이터를 보냄)
 코어 데이터에 저장된 데이터 (전체 데이터를 보관하고 있음)
 지금 당장 사용자에게 보여지고 있는 것 (코어데이터를 항상 반영함)
 */

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
    var toDoTasks: [ToDoTask] = []
    var doingTasks: [DoingTask] = []
    var doneTasks: [DoneTask] = []

    private init() {
        fetchTasks()
    }

    func createTask(title: String, description: String, date: Date) {
        viewContext.perform { [weak self] in
            guard let self = self else { return }
            let newTask = ToDoTask(context: self.viewContext)
            newTask.title = title
            newTask.body = description
            newTask.status = "toDo"
            newTask.date = date.timeIntervalSince1970

            self.toDoTasks.append(newTask)
            self.taskManagerDelegate?.taskDidCreated()

            do {
                try self.viewContext.save()
            } catch {

            }
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
                self.taskManagerDelegate?.taskDidEdited()
            }
        case .DOING:
            viewContext.perform { [weak self] in
                guard let self = self else { return }
                self.doingTasks[indexPath.row].title = title
                self.doingTasks[indexPath.row].body = description
                self.doingTasks[indexPath.row].date = date.timeIntervalSince1970
                self.taskManagerDelegate?.taskDidEdited()
            }
        case .DONE:
            viewContext.perform { [weak self] in
                guard let self = self else { return }
                self.doneTasks[indexPath.row].title = title
                self.doneTasks[indexPath.row].body = description
                self.doneTasks[indexPath.row].date = date.timeIntervalSince1970
                self.taskManagerDelegate?.taskDidEdited()
            }
        }

        do {
            try viewContext.save()
        } catch {

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
                do {
                    try self.viewContext.save()
                } catch {

                }
            }
        case .DOING:
            viewContext.perform { [weak self] in
                guard let self = self else { return }
                self.viewContext.delete(self.doingTasks[indexPath.row])
                self.doingTasks.remove(at: indexPath.row)
                self.taskManagerDelegate?.taskDidDeleted(indexPath: indexPath, status: .DOING)
                do {
                    try self.viewContext.save()
                } catch {

                }
            }
        case .DONE:
            viewContext.perform { [weak self] in
                guard let self = self else { return }
                self.viewContext.delete(self.doneTasks[indexPath.row])
                self.doneTasks.remove(at: indexPath.row)
                self.taskManagerDelegate?.taskDidDeleted(indexPath: indexPath, status: .DONE)
                do {
                    try self.viewContext.save()
                } catch {

                }
            }
        }
    }

    private func fetchTasks() {
        do {
            let request = ToDoTask.fetchRequest() as NSFetchRequest<ToDoTask>
            self.toDoTasks = try viewContext.fetch(request)
        } catch {
            return
        }
    }
}
