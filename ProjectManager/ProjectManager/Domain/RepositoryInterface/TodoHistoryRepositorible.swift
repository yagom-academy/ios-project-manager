//
//  TodoHistoryRepositorible.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/19.
//

import Foundation
import Combine

protocol TodoHistoryRepositorible {
    func create(_ item: TodoHistory)
    func todoHistoriesPublisher() -> CurrentValueSubject<HistoryStorageState, Never>
    func delete(item: TodoHistory)
}
