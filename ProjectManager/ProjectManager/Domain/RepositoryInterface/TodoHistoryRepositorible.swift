//
//  TodoHistoryRepositorible.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/19.
//

import Foundation
import Combine

protocol TodoHistoryRepositorible {
    func create(_ item: TodoHistory) -> AnyPublisher<Void, StorageError>
    func read() -> CurrentValueSubject<[TodoHistory], Never>
    func delete(item: TodoHistory) -> AnyPublisher<Void, StorageError>
}
