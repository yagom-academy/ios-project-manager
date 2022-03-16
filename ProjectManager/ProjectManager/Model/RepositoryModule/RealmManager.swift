//
//  RealmManager.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/03/15.
//

import Foundation
import RealmSwift

final class RealmManager<Element: Object>: RepositoryManager {
    
    private let localRealm = try? Realm()
    
    private var database: Realm {
        get throws {
            guard let database = localRealm else {
                throw RealmManagerError.localDBInitFailure
            }
            return database
        }
    }
    
    func create(_ objects: [Element]) throws {
        try database.write {
            try database.add(objects)
        }
    }
    
    func create(_ object: Element) throws {
        try database.write {
            try database.add(object)
        }
    }
    
    func fetch() throws -> [Element] {
        let results = try database.objects(Element.self)
        return Array(results)
    }
    
    func fetch(queryHandler: ((Element) -> Bool)) throws -> [Element] {
        let results = try database.objects(Element.self).filter(queryHandler)
        return Array(results)
    }
    
    func update(_ objects: [Element]) throws {
        try database.write {
            try database.add(objects, update: .modified)
        }
    }
    
    func update(_ object: Element) throws {
        try database.write {
            try database.add(object, update: .modified)
        }
    }
    
    func remove(_ objects: [Element]) throws {
        try database.write {
            try database.delete(objects)
        }
    }
    
    func remove(_ object: Element) throws {
        try database.write {
            try database.delete(object)
        }
    }
    
    func removeAll() throws {
        try database.write {
            try database.deleteAll()
        }
    }
    
    enum RealmManagerError: Error {
        
        case localDBInitFailure
        case objectNotExist
        
    }
    
}
