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
        var isConnected: Bool = false
        
        let connectedRef = self.database.reference(withPath: ".info/connected")
        connectedRef.observe(.value, with: { snapshot in
          if snapshot.value as? Bool ?? false {
              isConnected = true
          } else {
              isConnected = false
          }
            completion(isConnected)
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
            
            guard let folder = snapshot?.value as? [String: Any] else {
                return
            }
            
            folder.forEach { (key, value) in
                guard let todoDictionary = value as? [String : Any] else {
                    return
                }

                guard let todo = Todo(dictionary: todoDictionary) else {
                    return
                }

                todoArray.append(todo)
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
