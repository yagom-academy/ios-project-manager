//
//  ProjectManager.swift
//  ProjectManager
//
//  Created by 우롱차, 파프리 on 05/07/2022.
//

import Foundation

final class ProjectManager {
    private let realm: RealmManagerable
    
    init(realm: RealmManager) {
        self.realm = realm
    }
    
    func create(project: Project) throws {
        try realm.create(project: project)
    }
    
    func read(id: String) -> Project? {
        let predicate = NSPredicate(format: "id = %@", id)
        return realm.read(predicate: predicate)
    }
    
    func readAll() -> [Project] {
        return realm.readAll()
    }
    
    func update(project: Project) throws {
        try realm.update(project: project)
    }
    
    func delete(project: Project) throws {
        try realm.delete(project: project)
    }
}
