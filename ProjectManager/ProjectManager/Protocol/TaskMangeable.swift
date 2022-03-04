//
//  TaskMangeable.swift
//  ProjectManager
//
//  Created by 이차민 on 2022/03/02.
//

import Foundation

protocol TaskMangeable {
    var repository: Repository { get set }
    init(repository: Repository)
    
    func create(with task: Task)
    func fetchAll() -> [Task]
    func update(with task: Task)
    func delete(with task: Task)
    func changeState(of task: Task, to state: TaskState)
}
