//
//  RealmManager.swift
//  ProjectManager
//
//  Created by Donnie, Grumpy on 2022/07/08.
//

import RealmSwift
import UserNotifications

struct RealmManager {
    private let realmInstance = try? Realm()
    
    func create(task: Task) throws {
        do {
            try realmInstance?.write {
                realmInstance?.add(task)
            }
        } catch {
            throw DatabaseError.createError
        }
    }
    
    func fetchAllTasks() -> [Task] {
        guard let result = realmInstance?.objects(Task.self) else { return [] }
        return Array(result)
    }
    
    func fetchTasks(type: TaskType) -> [Task] {
        let result = realmInstance?.objects(Task.self).where {
            $0.taskType == type
        }
        guard let tasks = result else { return [] }
        return tasks.filter { $0 == $0 }
    }
    
    func update(task: Task) throws {
        do {
            try realmInstance?.write {
                realmInstance?.add(task, update: .modified)
            }
        } catch {
            throw DatabaseError.updateError
        }
    }
    
    func delete(task: Task) throws {
        do {
            try realmInstance?.write {
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [task.id])
                realmInstance?.delete(task)
            }
        } catch {
            throw DatabaseError.deleteError
        }
    }
    
    func change(task: Task, targetType: TaskType) throws {
        do {
            try realmInstance?.write {
                task.taskType = targetType
                realmInstance?.add(task, update: .modified)
            }
        } catch {
            throw DatabaseError.changeError
        }
    }
}
