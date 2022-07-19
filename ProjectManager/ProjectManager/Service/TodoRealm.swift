//
//  TodoRealm.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/19.
//

import Foundation
import RealmSwift

class TodoRealm: Object {
  @Persisted var id: UUID
  @Persisted var title: String
  @Persisted var content: String
  @Persisted var date: Date
  @Persisted var status: String
  
  convenience init(id: UUID = UUID(), title: String, content: String, date: Date = Date(), status: String = "TODO") {
    self.init()
    self.id = id
    self.title = title
    self.content = content
    self.date = date
    self.status = status
  }
  
  enum Status: String {
    case todo = "TODO"
    case doing = "DOING"
    case done = "DONE"
  }
  
  private func setRealmData() {
    let realmData = TodoRealm()
    realmData.title = ""
    realmData.content = ""
    realmData.date = Date()
    realmData.status = "TODO"

    guard let realm = try? Realm() else { return }
    try? realm.write {
      realm.add(realmData)
    }
  }

  private func getRealmData() -> TodoRealm {
    guard let realm = try? Realm() else { return TodoRealm() }

    let filteredData = realm.objects(TodoRealm.self)
    let arrData = Array(filteredData)
    guard let resultData = arrData.first else { return TodoRealm() }

    return resultData
  }

  private func removeRealmData() {
    guard let realm = try? Realm() else { return }
    try? realm.write {
      realm.delete(realm.objects(TodoRealm.self))
    }
  }

  func loadPersonData() -> [TodoRealm] {
    guard let realm = try? Realm() else { return [] }
    let todoData = realm.objects(TodoRealm.self)
    return Array(todoData)
  }
  
}
