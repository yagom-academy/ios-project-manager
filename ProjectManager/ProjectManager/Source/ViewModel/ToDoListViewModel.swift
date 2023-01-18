//  ProjectManager - ToDoListViewModel.swift
//  created by zhilly on 2023/01/18

import Foundation

class ToDoListViewModel {
    let state: String = ToDoState.toDo.description
    
    let model: Observable<[ToDo]> = Observable([])
    
    func addToDo(item: ToDo) {
        model.value.append(item)
    }
}
