//
//  ToDoViewModel.swift
//  ProjectManager
//
//  Created by 이차민 on 2022/03/02.
//

import Foundation

class ToDoViewModel: ViewModel {
    private var todoManager: ToDoManager
    private var todos = [ToDo]()
    
    init(todoManager: ToDoManager) {
        self.todoManager = todoManager
        self.refreshTodos()
    }
    
    private func refreshTodos() {
        todos = todoManager.fetchAll()
    }
    
    func create(with todo: ToDo) {
        todoManager.create(with: todo)
        refreshTodos()
    }
    
    func update(with todo: ToDo) {
        todoManager.update(with: todo)
        refreshTodos()
    }
    
    func delete(with todo: ToDo) {
        todoManager.delete(with: todo)
        refreshTodos()
    }
    
    func changeState(of todo: ToDo, to state: ToDoState) {
        todoManager.changeState(of: todo, to: state)
        refreshTodos()
    }
    
    func fetchToDo(at index: Int, with state: ToDoState) -> ToDo {
        let filteredTodos = todos.filter { $0.state == state }
        return filteredTodos[index]
    }
    
    func count(of state: ToDoState) -> Int {
        return todos.filter { $0.state == state }.count
    }
}
