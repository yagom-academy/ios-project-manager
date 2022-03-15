//
//  TaskManager.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/03/01.
//

import Foundation

protocol TaskManager {
    
    var todoTasks: [Task] { get }
    var doingTasks: [Task] { get }
    var doneTasks: [Task] { get }
    
    mutating func create(_ task: Task) throws
    mutating func delete(_ task: Task) throws
    mutating func update(_ oldTask: Task, to newTask: Task) throws
    
}

protocol RepositoryDataSource: AnyObject {
    
    associatedtype Element
    
    var queryAllRecords: [Element] { get }
    
    func create(_ object: Element) throws
    func delete(_ object: Element) throws
    func update(_ object: Element) throws
    func removeAllRecords() throws
    
}
