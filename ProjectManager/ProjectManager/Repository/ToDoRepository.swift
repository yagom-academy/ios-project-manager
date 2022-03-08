//
//  ToDoRepository.swift
//  ProjectManager
//
//  Created by 서녕 on 2022/03/04.
//

import Foundation

class ToDoRepository {
    var todos = [UUID: ToDoInfomation]()    //데이터베이스 역할(엔티티)
    
    func save(with todo: ToDoInfomation) {
        todos[todo.id] = todo
    }
    
    func delete(with todo: ToDoInfomation) {
        todos.removeValue(forKey: todo.id)
    }
    
    func update(with todo: ToDoInfomation) {
        todos.updateValue(todo, forKey: todo.id)
    }
    
    func changePosition(
        to: ToDoPosition,
        target: UUID
    ) {
        todos[target]?.position = to
    }
    
    func fetch(onCompleted: @escaping ([ToDoInfomation]) -> Void) {
        let todoData = todos.map { $0.value }
        onCompleted(todoData)
    }
}
