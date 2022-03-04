//
//  TaskCellViewModel.swift
//  ProjectManager
//
//  Created by 서녕 on 2022/03/04.
//

import Foundation

class ToDoViewModel {
    let dataManager = TestDataManager()
    var todoOnUpdated: (() -> Void) = {}
    var todos = [ToDoInfomation]() {
        didSet {
            todos = todos.sorted { $0.deadline > $1.deadline }
            todoOnUpdated()
        }
    }
        
    func save(todo: ToDoInfomation) {
        dataManager.save(todo: todo)
        self.reload()
    }
    
    func delete(todo: ToDoInfomation) {
        dataManager.delete(at: todo)
        self.reload()
    }
    
    func update(todo: ToDoInfomation) {
        dataManager.update(todo: todo)
        self.reload()
    }
    
    func changePosition(todo: ToDoInfomation, position: ToDoPosition) {
        dataManager.changePosition(todo: todo, position: position)
        self.reload()
    }
    
    func reload() {
        dataManager.fetch { [weak self] todoList in
            guard let self = self else {
                return
            }
            self.todos = todoList
        }
    }
}
