//
//  HistoryRepository.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/25.
//

import Foundation
import RxSwift
import RxRelay

protocol HistoryRepository {
    func read() -> BehaviorSubject<[History]>
    func save(to data: History)
    var errorObserver: Observable<TodoError> { get }
}
