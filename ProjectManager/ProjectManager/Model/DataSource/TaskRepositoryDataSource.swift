//
//  RepositoryDataSource.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/03/15.
//

import Foundation

protocol TaskRepositoryDataSource: AnyObject {
    
    var fetchAllRecords: [Task] { get }
    
    func fetch(_ condition: ((Task) -> Bool)) throws -> [Task]
    func create(_ object: Task) throws
    func delete(_ object: Task) throws
    func update(_ object: Task) throws
    func removeAllRecords() throws
    
}
