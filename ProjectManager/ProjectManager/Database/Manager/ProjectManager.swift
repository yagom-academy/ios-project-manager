//
//  ProjectManager.swift
//  ProjectManager
//
//  Created by 우롱차, 파프리 on 05/07/2022.
//

import Foundation

final class ProjectManager {
    private let realmManager: RealmManagerable
    
    init(realmManager: RealmManager) {
        self.realmManager = realmManager
    }
    
    func create(project: Project) throws {
        try realmManager.create(project: project)
    }
    
    func read(id: String) -> Project? {
        let predicate = NSPredicate(format: "id = %@", id)
        return realmManager.read(predicate: predicate)
    }
    
    func readAll() -> [Project] {
        return realmManager.readAll()
    }
    
    func update(project: Project) throws {
        try realmManager.update(project: project)
    }
    
    func delete(project: Project) throws {
        try realmManager.delete(project: project)
    }
    
    func deleteAll() throws {
        try realmManager.deleteAll()
    }
}
