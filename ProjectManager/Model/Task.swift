//
//  Task.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/12.
//

import Foundation

struct Task: Identifiable, Equatable {
  let id = UUID()
  var title: String
  var date: Date
  var body: String
  var type: TaskType
  var isOverdate: Bool
  
  init(title: String, date: Date, body: String, type: TaskType) {
    self.title = title
    self.date = date
    self.body = body
    self.type = type
    self.isOverdate = (self.type == .done) && (self.date + (60*60*24) < Date()) == true
  }
}

enum TaskType: Identifiable, CaseIterable {
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
