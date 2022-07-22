//
//  FirebaseService.swift
//  ProjectManager
//
//  Created by 김동욱 on 2022/07/19.
//

import Foundation

import Firebase

final class FirebaseDatabase {
    private let database = Database.database()
    private let firebase: DatabaseReference?
    
    init() {
        self.firebase = self.database.reference()
    }
    
    func isConnected(completion: @escaping (Bool) -> Void) {
        let isConnected = self.database.reference(withPath: ".info/connected")
        isConnected.observe(.value, with: { snapshot in
          if snapshot.value as? Bool ?? false {
              completion(true)
          } else {
              completion(false)
          }
        })
    }
    
    func sync(todoData: [Todo]) {
        todoData.forEach {
            let todoListReference = self.firebase?.child("TodoList/\($0.identifier.uuidString)")
            todoListReference?.setValue($0.dictionary)
        }
    }
    
    func create(todoData: Todo) {
        let todoListReference = self.firebase?
            .child("TodoList/\(todoData.identifier.uuidString)")
        
        todoListReference?.setValue(todoData.dictionary)
    }
    
    func read(completion: @escaping ([Todo]) -> Void) {
        var todoArray: [Todo] = []
        self.firebase?.child("TodoList").getData(completion: { error, snapshot in
            guard error == nil else {
                return
            }
            
            guard let todoLists = snapshot?.value as? [String: Any] else {
                return
            }
            
            todoLists.forEach { (key, value) in
                guard let todoDictionary = value as? [String : Any] else {
                    return
                }

                guard let todoData = Todo(dictionary: todoDictionary) else {
                    return
                }

                todoArray.append(todoData)
            }
            completion(todoArray)
        })
    }
    
    func update(selectedTodo: Todo) {
        self.firebase?.child("TodoList/\(selectedTodo.identifier)")
            .updateChildValues(selectedTodo.dictionary)
    }
    
    func delete(todoID: UUID) {
        self.firebase?.child("TodoList").child("\(todoID)")
            .removeValue()
    }
}
