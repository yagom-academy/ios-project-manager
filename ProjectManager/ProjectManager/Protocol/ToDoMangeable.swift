//
//  ToDoMangeable.swift
//  ProjectManager
//
//  Created by 이차민 on 2022/03/02.
//

import Foundation

protocol ToDoMangeable {
    var repository: Repository { get set }
    init(repository: Repository)
    
    func create(with todo: ToDo)
    func fetchAll() -> [ToDo]
    func update(with todo: ToDo)
    func delete(with todo: ToDo)
    func changeState(of todo: ToDo, to state: ToDoState)
}
