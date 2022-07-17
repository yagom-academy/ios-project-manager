//
//  LocalDB.swift
//  ProjectManager
//
//  Created by LIMGAUI on 2022/07/12

import Foundation
import Combine
import RealmSwift

final class RealmService: StorageType {
  private var realm = try? Realm()
  private let items = CurrentValueSubject<[Todo], Never>([])
  
  func create(_ todo: Todo) {
    let todoModel = TodoModel(title: todo.title, content: todo.content, state: todo.state)
    
    do {
      try realm?.write {
        realm?.add(todoModel)
      }
    } catch {
      print(error)
    }
  }
  
  func read() -> AnyPublisher<[Todo], Never> {
    return items.eraseToAnyPublisher()
  }
  
  func update(_ todo: Todo) {}
  
  func delete(_ todo: Todo) {}
}
