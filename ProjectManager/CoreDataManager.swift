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
    
    func moveItem(from sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // 선택한 아이템을 가져옴
        let itemToMove = entities.remove(at: sourceIndexPath.item)

        // 새로운 위치에 아이템을 삽입
        entities.insert(itemToMove, at: destinationIndexPath.item)

        // 변경 내용을 저장
        saveToContext()
    }
}
