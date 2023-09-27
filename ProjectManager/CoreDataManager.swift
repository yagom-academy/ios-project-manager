//
//  CoreDataManager.swift
//  ProjectManager
//
//  Created by 박종화 on 2023/09/27.
//

import UIKit

final class CoreDataManager {
    
    static var shared: CoreDataManager = CoreDataManager()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var entities: [Entity] = []
    
    func saveToContext() {
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func createEntity(title: String, body: String) {
        let newEntity = Entity(context: context)
        newEntity.title = title
        newEntity.body = body
        newEntity.duration = Date()
        
        saveToContext()
        getAllEntity()
    }
    
    func getAllEntity() {
        do {
            entities = try context.fetch(Entity.fetchRequest())
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateEntity(entity: Entity, newTitle: String, newBody: String) {
        entity.title = newTitle
        entity.body = newBody
        entity.duration = Date()
        
        saveToContext()
    }
    
    func deleteEntity(entity: Entity) {
        context.delete(entity)
        
        saveToContext()
    }
}
