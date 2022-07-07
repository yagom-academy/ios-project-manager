//
//  Memo.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/06.
//

import SwiftUI

class Todo: Identifiable, ObservableObject {
  let id: UUID
  @Published var title: String
  @Published var content: String
  @Published var date: Date
  @Published var status: Status
  
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
