//
//  TodoDatabaseManager.swift
//  ProjectManager
//
//  Created by Baek on 2022/09/19.
//

import Foundation
import RxRelay

protocol TodoDatabaseManager {
    var todoListViewBehaviorRelay: BehaviorRelay<[TodoModel]> { get set }
    
    func create(todoData: TodoModel)
    func read()
    func update(updateTodoData: TodoModel)
    func delete(deleteTodoData: UUID)
}
