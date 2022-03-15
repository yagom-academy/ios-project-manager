//
//  RepositoryManager.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/03/15.
//

import Foundation

protocol RepositoryManager {
    
    associatedtype Element
    
    func create(_ objects: [Element]) throws
    func create(_ object: Element) throws
    
    func fetch(objects type: Element.Type) throws -> [Element]
    func fetch(objects type: Element.Type,
               queryHandler: ((Element) -> Bool)) throws -> [Element]
    
    func update(objects: [Element]) throws
    func update(object: Element) throws
    
    func remove(_ objects: [Element]) throws
    func remove(_ object: Element) throws
    func removeAll() throws
    
}
