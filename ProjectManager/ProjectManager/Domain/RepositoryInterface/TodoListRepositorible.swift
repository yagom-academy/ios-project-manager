//
//  TodoListRepository.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/06.
//

import Foundation
import Combine

protocol TodoListRepositorible {
    func create(_ item: Todo) -> AnyPublisher<Void, RealmError>
    func read() -> CurrentValueSubject<[Todo], Never>
    func update(_ item: Todo) -> AnyPublisher<Void, RealmError>
    func delete(item: Todo) -> AnyPublisher<Void, RealmError>
    func deleteLastItem() -> AnyPublisher<Void, RealmError>
}
