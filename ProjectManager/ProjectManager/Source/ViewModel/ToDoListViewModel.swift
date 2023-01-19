//  ProjectManager - ToDoListViewModel.swift
//  created by zhilly on 2023/01/18

import Foundation

class ToDoListViewModel {
    let state: String = ToDoState.toDo.description
    
    let model: Observable<[ToDo]> = Observable([])
    
    func addToDo(item: ToDo) {
        model.value.append(item)
    }
    
    func fetchToDo(index: Int) -> ToDo? {
        return model.value[index]
    }
    
    func update(indexPath: Int, title: String, body: String, deadline: Date) {
        var data = model.value[indexPath]
        data.title = title
        data.body = body
        data.deadline = deadline
        
        self.model.value[indexPath] = data
    }
    
    func delete(indexPath: Int) {
        model.value.remove(at: indexPath)
    }
}
