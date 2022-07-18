//
//  TodoModel.swift
//  ProjectManager
//
//  Created by LIMGAUI on 2022/07/12

import RealmSwift

final class TodoModel: Object {
  @Persisted var title: String
  @Persisted var content: String
  @Persisted var date: Date
  @Persisted var state: State.RawValue
  @Persisted(primaryKey: true) var identifier: String
  
  convenience init(title: String, content: String, date: Date, state: State, id: String) {
    self.init()
    self.title = title
    self.content = content
    self.date = date
    self.state = state.rawValue
    self.identifier = id
  }
  
  func mappingTodo() -> Todo {
    return Todo(
      id: identifier,
      title: title,
      content: content,
      date: date,
      state: State(rawValue: state) ?? .todo)
  }
}
