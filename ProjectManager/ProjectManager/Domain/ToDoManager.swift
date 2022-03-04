//
//  ToDoManager.swift
//  ProjectManager
//
//  Created by 이차민 on 2022/03/02.
//

import Foundation

final class ToDoManager: ToDoMangeable {
    var repository: Repository
    
    required init(repository: Repository) {
        self.repository = repository
    }
    
    func create(with todo: ToDo) {
        repository.create(with: todo)
    }
    
    func fetchAll() -> [ToDo] {
        return repository.fetchAll()
    }
    
    func update(with todo: ToDo) {
        repository.update(with: todo)
    }
    
    func delete(with todo: ToDo) {
        repository.delete(with: todo)
    }
    
    func changeState(of todo: ToDo, to state: ToDoState) {
        let todoToChange = ToDo(id: todo.id,
                        title: todo.title,
                        description: todo.description,
                        deadline: todo.deadline,
                        state: state)
        
        repository.update(with: todoToChange)
    }
}
