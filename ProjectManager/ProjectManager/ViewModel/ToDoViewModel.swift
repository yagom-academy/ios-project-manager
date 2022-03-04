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
        
    func save(with todo: ToDoInfomation) {
        dataManager.save(with: todo)
        self.reload()
    }
    
    func delete(with todo: ToDoInfomation) {
        dataManager.delete(with: todo)
        self.reload()
    }
                                                 
    func update(with todo: ToDoInfomation) {
        dataManager.update(with: todo)
        self.reload()
    }
    
    func changePosition(with todo: ToDoInfomation, at position: ToDoPosition) {
        dataManager.changePosition(with: todo, at: position)
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
