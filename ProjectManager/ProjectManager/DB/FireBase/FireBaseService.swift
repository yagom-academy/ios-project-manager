//
//  FireBaseService.swift
//  ProjectManager
//
//  Created by LIMGAUI on 2022/07/19.
//

import Foundation
import Firebase
import Combine

final class FireBaseService: StorageType {
  static let shared = FireBaseService()
  private let firebaseRef: DatabaseReference!
  
  private var items = CurrentValueSubject<[Todo], Never>([])
  
  private init() {
    self.firebaseRef = Database.database().reference()
  }
  
  func create(_ todo: Todo) {
    firebaseRef.child(todo.id).setValue([
      "title": todo.title,
      "content": todo.content,
      "date": todo.date.timeIntervalSinceReferenceDate,
      "state": todo.state.rawValue,
      "id": todo.id
    ])
    
    items.send(items.value+[todo])
  }
  
  func read() -> AnyPublisher<[Todo], Never> {
    firebaseRef.observeSingleEvent(of: .value) { snapshot in
      guard let snapData = snapshot.value as? [String: Any] else {
        return
      }
      
      let todoList = snapData.values.compactMap { value -> Todo? in
        guard let value = value as? [String: Any] else {
          return nil
        }
        
        guard let content = value["content"] as? String,
              let date = value["date"] as? Double,
              let id = value["id"] as? String,
              let stateString = value["state"] as? String,
              let state = State(rawValue: stateString),
              let title = value["title"] as? String else {
          return nil
        }
        
        return Todo(
          id: id,
          title: title,
          content: content,
          date: Date(timeIntervalSinceReferenceDate: date),
          state: state
        )
      }
      
      self.items.send(todoList)
    }
    
    return items.eraseToAnyPublisher()
  }
  
  func update(_ todo: Todo) {
    firebaseRef.child(todo.id).setValue([
      "title": todo.title,
      "content": todo.content,
      "date": todo.date.timeIntervalSinceNow,
      "state": todo.state.rawValue,
      "id": todo.id
    ])
    
    guard let index = items.value.firstIndex(where: { $0.id == todo.id }) else {
      return
    }
    
    var todos = items.value
    todos[index] = todo
    
    items.send(todos)
  }
  
  func delete(_ todo: Todo) {
    firebaseRef.child(todo.id).removeValue()
    
    var todos = items.value
    todos.removeAll(where: { $0.id == todo.id })
    
    items.send(todos)
  }
}
