//
//  RealmService.swift
//  ProjectManager
//
//  Created by LIMGAUI on 2022/07/12

import Foundation
import Combine
import RealmSwift

final class RealmService: StorageType {
  static let shared = RealmService()
  private init() {}
  private let realm = try? Realm()
  private var items = CurrentValueSubject<[Todo], Never>([])
  
  func create(_ todo: Todo) {
    let todoModel = TodoModel(
      title: todo.title, content: todo.content, date: todo.date, state: todo.state, id: todo.id
    )
    
    do {
      try realm?.write {
        realm?.add(todoModel)
        readRealm()
      }
    } catch {
      print(error)
    }
  }
  
  func read() -> AnyPublisher<[Todo], Never> {
    readRealm()
    
    return items.eraseToAnyPublisher()
  }
  
  func update(_ todo: Todo) {
    let todoModel = TodoModel(
      title: todo.title, content: todo.content, date: todo.date, state: todo.state, id: todo.id
    )
    
    do {
      try realm?.write {
        realm?.add(todoModel, update: .modified)
        readRealm()
      }
    } catch {
      print(error)
    }
  }
  
  func delete(_ todo: Todo) {
    guard let todoModel = realm?.object(ofType: TodoModel.self, forPrimaryKey: todo.id) else {
      return
    }
    
    do {
      try realm?.write {
        realm?.delete(todoModel)
        readRealm()
      }
    } catch {
      print(error)
    }
  }

  private func readRealm() {
    guard let todoModels = realm?.objects(TodoModel.self) else {
      return
    }
    
    let todoList = todoModels
      .map {
        Todo(id: $0.identifier,
             title: $0.title,
             content: $0.content,
             date: $0.date,
             state: State(rawValue: $0.state) ?? .todo)
      }
    items.send(Array(todoList))
  }
}
