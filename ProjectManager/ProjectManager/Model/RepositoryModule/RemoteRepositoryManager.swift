//
//  RemoteRepositoryManager.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/03/21.
//

import Foundation

protocol RemoteRepositoryManager {
    
    func create(_ object: FirebaseTask) async throws
    func fetch() async throws -> [FirebaseTask]
    func update(_ object: FirebaseTask) async throws
    func remove(_ object: FirebaseTask) async throws
    func removeAll() async throws
    
}
