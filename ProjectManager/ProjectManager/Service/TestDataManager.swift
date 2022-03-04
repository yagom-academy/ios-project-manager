//
//  DataList.swift
//  ProjectManager
//
//  Created by 서녕 on 2022/03/02.
//

import Foundation

class TestDataManager {
    let todoRepository = ToDoRepository()
    var todoList: [ToDoInfomation] = []
    
    func save(with todo: ToDoInfomation) {
        todoRepository.save(with: todo)
    }
    
    func delete(with deletTarget: ToDoInfomation) {
        todoRepository.delete(with: deletTarget)
    }
    
    func update(with todo: ToDoInfomation) {
        todoRepository.update(with: todo)
    }
    
    func fetch(onComleted: @escaping ([ToDoInfomation]) -> Void) {
        todoRepository.fetch { [weak self] todoData in
            let todoList = todoData
            self?.todoList = todoData
            onComleted(todoList)
        }
    }
    
    func changePosition(with todo: ToDoInfomation, at position: ToDoPosition) {
        var changedToDo = todo
        changedToDo.position = position
        todoRepository.update(with: changedToDo)
    }
}
