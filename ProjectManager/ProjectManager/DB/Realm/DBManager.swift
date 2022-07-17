//
//  TodoManager.swift
//  ProjectManager
//
//  Created by LIMGAUI on 2022/07/14.
//

import Foundation

final class DBManager {
  static let shared = DBManager(realmManager: RealmService())
  private let realmManager: RealmService
  
  init(realmManager: RealmService) {
    self.realmManager = realmManager
  }
  
  func create(_ object: TodoModel) {
    realmManager.create(object)
  }
  
  func readAll() -> [TodoModel] {
    return realmManager.readAll()
  }
  
  func update(_ object: TodoModel, with data: [String: Any?]) {
    realmManager.update(object, with: data)
  }
  
  func delete(_ object: TodoModel) {
    realmManager.delete(object)
  }
  
  func mappingTodoModel(from todo: Todo) -> TodoModel {
    return TodoModel(title: todo.title, content: todo.content, state: todo.state)
  }
}
