//
//  TaskRemoteDataSource.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/03/15.
//

import Foundation
import Metal

final class TaskRemoteDataSource<Element>: RepositoryDataSource {
    
    var fetchAllRecords: [Element] {
        []
    }
    
    func fetch(_ condition: ((Element) -> Bool)) throws -> [Element] {
        print(#function)
        return []
    }
    
    func create(_ object: Element) throws {
        print(#function)
    }
    
    func delete(_ object: Element) throws {
        print(#function)
    }
    
    func update(_ object: Element) throws {
        print(#function)
    }
    
    func removeAllRecords() throws {
        print(#function)
    }
    
}
