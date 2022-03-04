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
    
    func save(todo: ToDoInfomation) {
        todoRepository.save(todo: todo)
    }
    
    func delete(at deletTarget: ToDoInfomation) {
        todoRepository.delete(todo: deletTarget)
    }
    
    func update(todo: ToDoInfomation) {
        todoRepository.update(todo: todo)
    }
    
    func fetch(onComleted: @escaping ([ToDoInfomation]) -> Void) {
        todoRepository.fetch { [weak self] todoData in
            let todoList = todoData
            self?.todoList = todoData
            onComleted(todoList)
        }
    }
    
    func changePosition(todo: ToDoInfomation, position: ToDoPosition) {
        var changedToDO = todo
        changedToDO.position = position
        todoRepository.update(todo: changedToDO)
    }
}
