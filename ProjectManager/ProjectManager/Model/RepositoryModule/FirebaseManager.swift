//
//  FirebaseManager.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/03/21.
//

import Foundation
import Firebase

final class FirebaseManager<Element: Codable>: LocalRepositoryManager {
    
    private let database = Firestore.firestore()
    
    private let collectionLink = "tasks"
    private let documentLink = "task"
    
    func create(_ objects: [Element]) throws {
       
            
    }
    
    func create(_ object: Element) throws {
        
    }
    
    func fetch() throws -> [Element] {
       
    }
    
    func fetch(queryHandler: ((Element) -> Bool)) throws -> [Element] {
        
    }
    
    func update(_ objects: [Element]) throws {
        
    }
    
    func update(_ object: Element) throws {
        
    }
    
    func remove(_ objects: [Element]) throws {
        
    }
    
    func remove(_ object: Element) throws {
        
    }
    
    func removeAll() throws {
        
    }
    
}
