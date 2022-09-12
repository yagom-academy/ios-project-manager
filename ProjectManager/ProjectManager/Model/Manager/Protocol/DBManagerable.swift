//
//  DBManagerable.swift
//  ProjectManager
//
//  Created by Kiwi on 2022/09/11.
//

import Foundation

protocol DBManagerable {
    
    var todoTasks: [Todo] { get }
    var doingTasks: [Todo] { get }
    var doneTasks: [Todo] { get }
    
    func fetch() -> [Todo]
    func add(title: String, body: String, date: Date, status: Status)
    func delete(id: UUID)
    func update(id: UUID, title: String, body: String, date: Date)
    func changeStatus(id: UUID, to status: Status)
}
