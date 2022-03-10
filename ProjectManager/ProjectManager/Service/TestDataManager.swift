//
//  DataList.swift
//  ProjectManager
//
//  Created by 서녕 on 2022/03/02.
//

import Foundation

class TestDataManager {
    private let todoRepository = ToDoRepository()
    private var todoList: [ToDoInfomation] = []
    
    func save(with todo: ToDoInfomation) {
        todoRepository.save(with: todo)
    }
    
    func delete(with deletTarget: ToDoInfomation) {
        todoRepository.delete(with: deletTarget)
    }
    
    func fetch(onComleted: @escaping ([ToDoInfomation]) -> Void) {
        todoRepository.fetch { [weak self] todoData in
            let todoList = todoData
            self?.todoList = todoData
            onComleted(todoList)
        }
    }
    
    func changePosition(
        to position: ToDoPosition,
        target id: UUID
    ) {
        todoRepository.changePosition(to: position, target: id)
    }
}
