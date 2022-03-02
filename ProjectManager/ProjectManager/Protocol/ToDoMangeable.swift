//
//  ToDoMangeable.swift
//  ProjectManager
//
//  Created by 이차민 on 2022/03/02.
//

import Foundation

protocol ToDoMangeable {
    var repository: Repository { get set }
    
    func create(with todo: ToDo)
    func fetchAll() -> [ToDo]
    func update(at id: UUID, todo: ToDo)
    func delete(at id: UUID)
    func changeState(of id: UUID, to state: ToDoState)
    func fetchToDo(at id: UUID) -> ToDo
    func count(of state: ToDoState) -> Int
}
