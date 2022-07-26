//
//  SomeViewModel.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/12.
//

import RealmSwift

class TaskManagementService {
  var tasks: [Task] = []
  private var realm: Realm?
  
  init() {
    do {
      try self.realm = Realm()
    } catch {
      print(error)
    }
    self.tasks = self.read()
  }
  

  func create(_ task: Task) {
    do {
      try realm?.write({
        let task = Task(title: task.title,
                        date: task.date,
                        body: task.body,
                        type: .todo)
        realm?.add(task)
        self.tasks = self.read()
      })
    } catch {
      print(error)
    }
  }
  
  func read() -> [Task] {
    guard let tasks = realm?.objects(Task.self) else {
      return []
    }
    
    return Array(tasks)
  }
  
  func update(task: Task) {
    let tasks = read()
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
        realm?.delete(task)
      })
    } catch {
      print(error)
    }
  }
  
  func move(_ task: Task, type: TaskType) {
    do {
      try realm?.write({
        task.type = type
        self.tasks = read()
      })
    } catch {
      print(error)
    }
  }
}
