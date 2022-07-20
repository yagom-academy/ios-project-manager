//
//  TodoRealm.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/19.
//

import Foundation
import RealmSwift

class TodoRealm: Object {
  @Persisted(primaryKey: false) var id: UUID
  @Persisted var title: String
  @Persisted var content: String
  @Persisted var date: Date
  @Persisted var status: Status
  
  convenience init(id: UUID = UUID(), title: String, content: String, date: Date = Date(), status: Status = .todo) {
    self.init()
    self.id = id
    self.title = title
    self.content = content
    self.date = date
    self.status = status
  }
}
