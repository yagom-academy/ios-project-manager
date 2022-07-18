//
//  TodoListRepository.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/08.
//

import Foundation
import RxSwift

protocol TodoListRepository {
    func read() -> BehaviorSubject<[TodoModel]>
    func save(to data: TodoModel)
    func delete(index: Int)
}
