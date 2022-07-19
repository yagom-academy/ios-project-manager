//
//  FirebaseService.swift
//  ProjectManager
//
//  Created by 김동욱 on 2022/07/19.
//

import Foundation

import Firebase


final class FirebaseDatabase {
    var firebase: DatabaseReference?
    
    init() {
        self.firebase = Database.database().reference()
    }
    
    func create(todoData: Todo) {
        let todoListReference = self.firebase?.child("TodoList")
        let todoListValue: [String: Any] = ["": ""]
        
        todoListReference?.setValue(todoListValue)
    }
    
    func read() {
        
    }
    
    func update(selectedTodo: Todo) {
        
    }
    
    func delete(todoID: UUID) {
        
    }
}
