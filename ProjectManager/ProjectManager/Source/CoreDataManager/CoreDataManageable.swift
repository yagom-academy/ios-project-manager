//  ProjectManager - CoreDataManageable.swift
//  created by zhilly on 2023/01/27

import Foundation
import CoreData

protocol CoreDataManageable {
    associatedtype Object: ManagedObjectModel
    
    func add(_ object: Object) throws
    func fetchObjects() throws -> [Object]
    func update(_ object: Object) throws
    func remove(_ object: Object) throws
}
