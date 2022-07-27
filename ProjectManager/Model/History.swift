//
//  History.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/27.
//

import RealmSwift
import Foundation

class History: Object {
  @Persisted var title: String
  @Persisted var from: TaskType?
  @Persisted var to: TaskType?
  @Persisted var date: Date
  @Persisted var type: HistoryType
  
  convenience init(title: String, from: TaskType?, to: TaskType?, date: Date, type: HistoryType) {
    self.init()
    self.title = title
    self.from = from
    self.to = to
    self.date = date
    self.type = type
  }
}

enum HistoryType: String, PersistableEnum {
  case add
  case move
  case remove
  
  var title: String {
    switch self {
    case .add:
      return "Added"
    case .move:
      return "Moved"
    case .remove:
      return "Removed"
    }
  }
}
