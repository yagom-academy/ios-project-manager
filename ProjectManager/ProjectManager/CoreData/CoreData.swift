//
//  CoreData.swift
//  ProjectManager
//
//  Created by 최정민 on 2021/08/01.
//

import Foundation
import UIKit
import CoreData

typealias Handler = (Bool) -> Void

struct CoreData {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let directoryURL = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
    
    // MARK: Function for UpdatedFile
    
    func getTaskList() -> [TaskData]? {
        do {
            return try context.fetch(TaskData.fetchRequest())
        } catch {
            print(error)
            return nil
        }
    }
    
    func createTask(task: Task){
        let newTask = TaskData(context: context)
        newTask.title = task.title
        newTask.detail = task.detail
        newTask.deadline = task.deadline
        newTask.status = task.status
        newTask.id = task.id
        do {
            try context.save()
        } catch {
            print(error)
        }
    }

    func deleteTask(id: String) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "TaskData")
        fetchRequest.predicate = NSPredicate(format: "id = %@", id)
        do {
            let taskList = try context.fetch(fetchRequest)
            if taskList.count == 0 {
                return
            }
            let objectDelete = taskList[0] as! NSManagedObject
            context.delete(objectDelete)
            do {
                try context.save()
            } catch {
                print(error)
            }
        } catch {
            print(error)
        }
    }
    
    func patchData(task: Task) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "TaskData")
        fetchRequest.predicate = NSPredicate(format: "id = %@", task.id)
        do {
            let taskList = try context.fetch(fetchRequest)
            if taskList.count == 0 {
                return
            }
            let objectUpdate = taskList[0] as! NSManagedObject
            objectUpdate.setValue(task.title, forKey: "title")
            objectUpdate.setValue(task.deadline, forKey: "deadline")
            objectUpdate.setValue(task.status, forKey: "status")
            objectUpdate.setValue(task.detail, forKey: "detail")
            do {
                try context.save()
            } catch {
                print(error)
            }
        } catch {
            print(error)
        }
    }

    func pushTask(task: Task, httpMethod: String){
        let newBufferTask = TaskBuffer(context: context)
        newBufferTask.title = task.title
        newBufferTask.detail = task.detail
        newBufferTask.deadline = task.deadline
        newBufferTask.status = task.status
        newBufferTask.id = task.id
        newBufferTask.httpMethod = httpMethod
        do {
            try context.save()
        } catch {
            print(error)
        }
    }

    func popTask(id: String) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "TaskData")
        fetchRequest.predicate = NSPredicate(format: "id = %@", id)
        do {
            let taskList = try context.fetch(fetchRequest)
            if taskList.count == 0 {
                return
            }
            print("\n POP \n")
            let objectDelete = taskList[0] as! NSManagedObject
            context.delete(objectDelete)
            do {
                try context.save()
            } catch {
                print(error)
            }
        } catch {
            print(error)
        }
    }

}
