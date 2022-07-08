//
//  TodoListRepository.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/08.
//

import Foundation

protocol TodoListRepository {
    func read() -> [TodoModel]
    func save(to data: TodoModel)
}
