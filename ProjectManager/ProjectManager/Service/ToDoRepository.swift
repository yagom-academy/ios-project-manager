//
//  ToDoRepository.swift
//  ProjectManager
//
//  Created by 이차민 on 2022/03/02.
//

import Foundation

class ToDoRepository: Repository {
    private var todos = [UUID: ToDo]()
    
    func create(with todo: ToDo) {
        todos[todo.id] = todo
    }
    
    func fetchAll() -> [ToDo] {
        return todos.map { $0.value }
    }
    
    func update(with todo: ToDo) {
        todos.updateValue(todo, forKey: todo.id)
    }
    
    func delete(with todo: ToDo) {
        todos.removeValue(forKey: todo.id)
    }
}
