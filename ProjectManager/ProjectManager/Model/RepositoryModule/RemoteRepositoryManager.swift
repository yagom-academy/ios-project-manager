//
//  RemoteRepositoryManager.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/03/21.
//

import Foundation

protocol RemoteRepositoryManager {
    
    var fetchAllRecords: [FirebaseTask] { get }
    
    func create(_ object: FirebaseTask)
    func fetch()
    func removeAll()
    
}
