//
//  ToDo.swift
//  ProjectManager
//
//  Created by LIMGAUI on 2022/07/07.

import Foundation
import RealmSwift

struct Todo: Hashable {
  var title: String = ""
  var content: String = ""
  var date: Date = Date.now
  var state: State = .done
  var identifier: String = UUID().uuidString
  
  var readList: [Todo] {
    return [
      Todo(title: "test1", content: "쿼카 하이!쿼카 하이!쿼카 하이!쿼카 하이!쿼카 하이!쿼카 하이!쿼카 하이!쿼카 하이!쿼카 하이!쿼카 하이!쿼카 하이!쿼카 하이!쿼카 하이!쿼카 하이!쿼카 하이!쿼카 하이!쿼카 하이!쿼카 하이!쿼카 하이!쿼카 하이!쿼카 하이!쿼카 하이!쿼카 하이!쿼카 하이!쿼카 하이!쿼카 하이!쿼카 하이!쿼카 하이!쿼카 하이!쿼카 하이!쿼카 하이!쿼카 하이!쿼카 하이!쿼카 하이!쿼카 하이!쿼카 하이!쿼카 하이!쿼카 하이!쿼카 하이!", date: Date().addingTimeInterval(3600 * -24), state: .todo),
      Todo(title: "test2", content: "쿼카 하이!쿼카 하이!쿼카 하이!쿼카 하이!쿼카 하이!쿼카 하이!쿼카 하이!", date: Date(), state: .doing),
      Todo(title: "test3", content: "쿼카 하이!", date: Date().addingTimeInterval(3600 * -48), state: .done),
      Todo(title: "test4", content: "쿼카 하이!", date: Date(), state: .todo),
      Todo(title: "test5", content: "쿼카 하이!", date: Date().addingTimeInterval(3600 * 72), state: .done),
      Todo(title: "test6", content: "쿼카 하이!", date: Date(), state: .doing),
      Todo(title: "test7", content: "쿼카 하이!쿼카 하이!쿼카 하이!쿼카 하이!쿼카 하이!쿼카 하이!", date: Date(), state: .todo),
      Todo(title: "test8", content: "쿼카 하이!", date: Date().addingTimeInterval(3600 * -96), state: .todo),
      Todo(title: "test9", content: "쿼카 하이!쿼카 하이!쿼카 하이!쿼카 하이!쿼카 하이!쿼카 하이!쿼카 하이!", date: Date(), state: .todo),
      Todo(title: "test10", content: "쿼카 하이!쿼카 하이!쿼카 하이!", date: Date().addingTimeInterval(3600 * 96), state: .todo),
      Todo(title: "test11", content: "쿼카 하이!", date: Date().addingTimeInterval(3600 * 24), state: .todo),
      Todo(title: "test12", content: "쿼카 하이!", date: Date().addingTimeInterval(3600 * 12), state: .todo),
      Todo(title: "test13", content: "쿼카 하이!", date: Date().addingTimeInterval(3600 * 12), state: .todo),
      Todo(title: "test14", content: "쿼카 하이!", date: Date().addingTimeInterval(3600 * 48), state: .todo)
      ]
  }
}
