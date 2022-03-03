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
    func fetch(at index: Int, with state: ToDoState) throws -> ToDo
    func didSelectRow(at index: Int, with state: ToDoState)
    func count(of state: ToDoState) -> Int
}
