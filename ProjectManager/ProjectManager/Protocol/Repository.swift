//
//  Repository.swift
//  ProjectManager
//
//  Created by 이차민 on 2022/03/02.
//

import Foundation

protocol Repository {
    func create(with todo: ToDo)
    func fetch() -> [ToDo]
    func update(with todo: ToDo)
    func delete(with todo: ToDo)
}
