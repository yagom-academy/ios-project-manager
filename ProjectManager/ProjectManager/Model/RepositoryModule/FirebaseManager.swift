//
//  FirebaseManager.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/03/21.
//

import Foundation
import Firebase

final class FirebaseManager<Element: Codable>: RemoteRepositoryManager {
   
    private let database = Firestore.firestore()
    
    private let collectionLink = "tasks"
    private let documentLink = "task"
    
    func create(_ object: Element, completionHandler: (Result<Data, Error>) -> Void) {
        
    }
    
    func fetch(completionHandler: (Result<[Element], Error>) -> Void) {
        
    }
    
    func fetch(queryHandler: (Element) -> Bool, completionHandler: (Result<[Element], Error>) -> Void) {
        
    }
    
    func update(_ object: Element, completionHandler: (Result<Data, Error>) -> Void) {
        
    }
    
    func remove(_ object: Element, completionHandler: (Result<Data, Error>) -> Void) {
        
    }
    
    func removeAll(completionHandler: (Result<Data, Error>) -> Void) {
        
    }
    
}
