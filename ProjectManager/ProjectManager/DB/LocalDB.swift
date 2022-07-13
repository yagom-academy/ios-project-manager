//
//  LocalDB.swift
//  ProjectManager
//
//  Created by LIMGAUI on 2022/07/12

import Foundation
import RealmSwift

final class LocalDB: DBable {
  let shared = LocalDB()
  private init() {}
  
  typealias Element = Todo
  var realm = try? Realm()
  
  func create(_ todo: Todo) {
    let realmTodo = TodoModel(value: todo)
    do {
      try realm?.write({
        realm?.add(realmTodo)
      })
    } catch {
      
    }
  }
  
  func read(by id: String) -> Todo {
    return Todo()
  }
  
  func readAll() -> [Todo] {
    return [Todo]()
  }
  
  func update(_ todo: Todo) {
    
  }
  
  func delete(id: String) {
    
  }
}
