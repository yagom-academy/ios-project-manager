//
//  ToDoRepository.swift
//  ProjectManager
//
//  Created by 서녕 on 2022/03/04.
//

import Foundation

class ToDoRepository {
    var todos = [UUID: ToDoInfomation]()    //데이터베이스 역할(엔티티)
    
    func save(todo: ToDoInfomation) {
        todos[todo.id] = todo
    }
    
    func delete(todo: ToDoInfomation) {
        todos.removeValue(forKey: todo.id)
    }
    
    func update(todo: ToDoInfomation) {
        todos.updateValue(todo, forKey: todo.id)
    }
    
    func fetch(onCompleted: @escaping ([ToDoInfomation]) -> Void) {
//        todos = [UUID(): ToDoInfomation(id: UUID(), title: "sdfdsfdfs", discription: "sdfsdffsf", deadline: 343232345, position: .ToDo)]
        let todoData = todos.map { $0.value }
        onCompleted(todoData)
    }
    

}
