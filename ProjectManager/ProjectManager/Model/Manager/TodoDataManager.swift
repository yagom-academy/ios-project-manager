//
//  TodoDataManager.swift
//  ProjectManager
//
//  Created by Kiwi on 2022/09/11.
//

import Foundation

final class TodoDataManager: DBManagerable {
    
    private(set) var todoData: [Todo] = .init()
    var todoTasks: [Todo] {
        return todoData.filter { $0.status == .todo }
    }
    var doingTasks: [Todo] {
        return todoData.filter { $0.status == .doing }
    }
    var doneTasks: [Todo] {
        return todoData.filter { $0.status == .done }
    }
    
    func fetch() -> [Todo] {
        return todoData
    }
    
    func add(title: String, body: String, date: Date, status: Status) {
        self.todoData.append(Todo(title: title, body: body, date: date, status: .todo))
    }
    
    func delete(id: UUID) {
        self.todoData.removeAll(where: { $0.id == id })
    }
    
    func update(id: UUID, title: String, body: String, date: Date) {
        guard var selectedData = todoData.filter({ $0.id == id }).last else { return }
        
        selectedData.title = title
        selectedData.body = body
    }
    
    func changeStatus(id: UUID, to status: Status) {
        guard var selectedData = todoData.filter({ $0.id == id }).last else { return }
        
        selectedData.status = status
    }
    
}
