//
//  SomeViewModel.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/12.
//

import RealmSwift

class TaskManagementService {
  var allTasks: [Task] = []
  var allHistories: [History] = []
  private var realm: Realm?
  
  init() {
    do {
      try self.realm = Realm()
    } catch {
      print(error)
    }
    self.allTasks = self.readAllTasks()
  }
  

  func create(_ task: Task) {
    do {
      try realm?.write({
        let task = Task(title: task.title,
                        date: task.date,
                        body: task.body,
                        type: .todo)
        let history = History(title: task.title,
                              from: nil,
                              to: nil,
                              date: Date(),
                              type: .add)
        realm?.add(history)
        self.allHistories = self.readAllHistories()
        
        realm?.add(task)
        self.allTasks = self.readAllTasks()
        
      })
    } catch {
      print(error)
    }
  }
  
  func readAllTasks() -> [Task] {
    guard let tasks = realm?.objects(Task.self) else {
      return []
    }
    
    return Array(tasks)
  }
  
  func readAllHistories() -> [History] {
    guard let histories = realm?.objects(History.self) else {
      return []
    }
    
    return Array(histories)
  }
  
  func update(task: Task) {
    let tasks = readAllTasks()
    guard let index = tasks.firstIndex(of: task) else {
      return
    }
    
    do {
      try realm?.write({
        tasks[index].title = task.title
        tasks[index].body = task.body
        tasks[index].date = task.date
        tasks[index].type = task.type
      })
    } catch {
      print(error)
    }
  }
  
  func delete(task: Task) {
    do {
      try realm?.write({
        let history = History(title: task.title,
                              from: task.type,
                              to: nil,
                              date: Date(),
                              type: .remove)
        realm?.add(history)
        self.allHistories = readAllHistories()
        
        realm?.delete(task)
        self.allTasks = readAllTasks()
      })
    } catch {
      print(error)
    }
  }
  
  func move(_ task: Task, type: TaskType) {
    do {
      try realm?.write({
        let history = History(title: task.title,
                              from: task.type,
                              to: type,
                              date: Date(),
                              type: .move)
        realm?.add(history)
        self.allHistories = readAllHistories()
        
        task.type = type
        self.allTasks = readAllTasks()
      })
    } catch {
      print(error)
    }
  }
}
