//
//  Repository.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/06.
//

import Foundation
import Combine

protocol Repository {
    func create(_ item: TodoListModel)
    func read() -> AnyPublisher<[TodoListModel], Never>
    func update(_ item: TodoListModel)
    func delete(item: TodoListModel)
    func deleteLastItem()
}
