//
//  TodoListRepository.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/06.
//

import Foundation
import Combine

protocol TodoListRepositorible {
    func create(_ item: Todo)
    func todosPublisher() -> CurrentValueSubject<LocalStorageState, Never>
    func update(_ item: Todo)
    func delete(item: Todo)
    func synchronizeDatabase()
}
