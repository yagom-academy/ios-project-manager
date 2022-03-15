//
//  TaskRemoteDataSource.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/03/15.
//

import Foundation

final class TaskRemoteDataSource<Element>: RepositoryDataSource {
    
    var queryAllRecords: [Element] {
        []
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
