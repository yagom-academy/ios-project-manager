//
//  ToDoViewModel.swift
//  ProjectManager
//
//  Created by 이차민 on 2022/03/02.
//

import Foundation

class ToDoViewModel: ViewModel {
    var todoDidUpdated: (() -> Void)?
    var didSelectTodo: ((ToDo) -> Void)?
    
    private var todoManager: ToDoManager
    private(set) var todos = [ToDo]() {
        didSet {
            todos.sort { $0.deadline < $1.deadline }
        }
    }
    
    init(todoManager: ToDoManager) {
        self.todoManager = todoManager
    }
    
    func didLoaded() {
        updateTodos()
    }
    
    private func updateTodos() {
        todos = todoManager.fetchAll()
        todoDidUpdated?()
    }
    
    func create(with todo: ToDo) {
        todoManager.create(with: todo)
        updateTodos()
    }
    
    func update(with todo: ToDo) {
        todoManager.update(with: todo)
        updateTodos()
    }
    
    func delete(with todo: ToDo) {
        todoManager.delete(with: todo)
        updateTodos()
    }
    
    func changeState(of todo: ToDo, to state: ToDoState) {
        todoManager.changeState(of: todo, to: state)
        updateTodos()
    }
    
    func fetch(at index: Int, with state: ToDoState) throws -> ToDo {
        let filteredTodos = todos.filter { $0.state == state }
        guard let fetchedTodo = filteredTodos[safe: index] else {
            throw CollectionError.indexOutOfRange
        }
        
        return fetchedTodo
    }
    
    func didSelectRow(at index: Int, with state: ToDoState) {
        let filteredTodos = todos.filter { $0.state == state }
        guard let selectedTodo = filteredTodos[safe: index] else {
            return
        }
        
        didSelectTodo?(selectedTodo)
    }
    
    func count(of state: ToDoState) -> Int {
        return todos.filter { $0.state == state }.count
    }
}
