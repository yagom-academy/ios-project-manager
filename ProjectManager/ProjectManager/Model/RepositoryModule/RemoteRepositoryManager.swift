//
//  RemoteRepositoryManager.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/03/21.
//

import Foundation

protocol RemoteRepositoryManager {
    
    func create(_ object: FirebaseTask) throws
    func removeAll() throws
    
}
