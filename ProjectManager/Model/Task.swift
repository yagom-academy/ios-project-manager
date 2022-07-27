//
//  Task.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/12.
//

import RealmSwift

class Task: Object, ObjectKeyIdentifiable {
  @Persisted(primaryKey: true) var id = UUID()
  @Persisted var title: String
  @Persisted var date: Date
  @Persisted var body: String
  @Persisted var type: TaskType
  @Persisted var isOverdate: Bool
  
  convenience init(title: String, date: Date, body: String, type: TaskType) {
    self.init()
    self.title = title
    self.date = date
    self.body = body
    self.type = type
    self.isOverdate = (self.type == .done) && (self.date + (60*60*24) < Date()) == true
  }
}

enum TaskType: String, Identifiable ,PersistableEnum {
  case todo
  case doing
  case done
  
  var title: String {
    switch self {
    case .todo:
      return "TODO"
    case .doing:
      return "DOING"
    case .done:
      return "DONE"
    }
  }
  
  var id: String {
    return title
  }
}
