//
//  Repository.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/06.
//

import Foundation
import Combine

protocol Repository {
    func read() -> AnyPublisher<[TodoListModel], Never>
    func delete(item: TodoListModel)
}
