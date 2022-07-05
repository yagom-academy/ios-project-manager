//
//  ProjectManager.swift
//  ProjectManager
//
//  Created by 우롱차, 파프리 on 05/07/2022.
//

import Foundation
import RealmSwift

final class ProjectManager {
    private let realm: Realm
    
    init(realm: Realm) {
        self.realm = realm
    }
    
    func create(project: Project) throws {
        try realm.write {
            realm.add(project)
        }
    }
    
    func read(id: String) -> Project? {
        let predicate = NSPredicate(format: "id = %@", id)
        return realm.objects(Project.self)
                    .filter(predicate)
                    .first
    }
    
    func readAll() -> Results<Project> {
        return realm.objects(Project.self)
    }
    
    func update(project: Project) throws {
        try realm.write({
            realm.add(project, update: .modified)
        })
    }
    
    func delete(project: Project) throws {
        try realm.write({
            realm.delete(project)
        })
    }
}
