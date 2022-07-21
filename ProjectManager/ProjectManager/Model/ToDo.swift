//
//  ToDo.swift
//  ProjectManager
//
//  Created by LIMGAUI on 2022/07/07.

import Foundation
import RealmSwift

struct Todo: Hashable, Identifierable {
  var id: String = UUID().uuidString
  var title: String
  var content: String
  var date: Date
  var state: State = .todo
  
  static let dummy = [
    Todo(title: "1234", content: "12341234", date: .now, state: .todo),
    Todo(title: "542321", content: "412353", date: .now, state: .doing),
    Todo(title: "0987678", content: "09886", date: .now, state: .done)
  ]
}
