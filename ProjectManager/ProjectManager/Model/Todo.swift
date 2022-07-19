//
//  Memo.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/06.
//

import SwiftUI

struct Todo: Identifiable {
  let id: UUID
  var title: String
  var content: String
  var date: Date
  var status: Status
  
  enum Status: String {
    case todo = "TODO"
    case doing = "DOING"
    case done = "DONE"
  }
  
  init(id: UUID = UUID(), title: String, content: String, date: Date = Date(), status: Status = .todo) {
    self.id = id
    self.title = title
    self.content = content
    self.date = date
    self.status = status
  }
}
