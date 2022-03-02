//
//  ViewModel.swift
//  ProjectManager
//
//  Created by 이차민 on 2022/03/02.
//

import Foundation

protocol ViewModel {
    func create(with todo: ToDo)
    func update(with todo: ToDo)
    func delete(with todo: ToDo)
    func changeState(of todo: ToDo, to state: ToDoState)
    func fetchToDo(at index: Int, with state: ToDoState) -> ToDo
    func count(of state: ToDoState) -> Int
}
