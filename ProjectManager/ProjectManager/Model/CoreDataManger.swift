//
//  CoreDataManger.swift
//  ProjectManager
//
//  Created by Baem on 2023/01/15.
//

import CoreData
import UIKit

final class CoreDataManager {
    static let shared = CoreDataManager()
    
    private init() {}
    
    private let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    func fetchData() ->  Result<[TodoModel], CoreDataError> {
        let context = appDelegate?.persistentContainer.viewContext
        do {
            if let contact = try context?.fetch(TodoModel.fetchRequest()) {
                return .success(contact)
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return .failure(.fetchError)
    }
    
    func saveData(title: String, body: String, todoDate: Date) {
        guard let context = appDelegate?.persistentContainer.viewContext else { return }
        let entity = NSEntityDescription.entity(forEntityName: "TodoModel", in: context)
        
        if let entity = entity {
            let info = NSManagedObject(entity: entity, insertInto: context)
            info.setValue(title, forKey: "title")
            info.setValue(body, forKey: "body")
            info.setValue(todoDate, forKey: "todoDate")
            info.setValue(State.todo.rawValue, forKey: "state")
            info.setValue(UUID(), forKey: "id")
            
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func updateData(
        title: String? = nil,
        body: String? = nil,
        todoDate: Date? = nil,
        id: UUID,
        state: State
    ) {
        guard let context = appDelegate?.persistentContainer.viewContext else { return }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "TodoModel")
        fetchRequest.predicate = NSPredicate(format: "id = %@", id as CVarArg)
        
        do {
            let test = try context.fetch(fetchRequest)
            guard let updatingData = test[0] as? NSManagedObject else { return }
            
            if title != nil, body != nil, todoDate != nil {
                updatingData.setValue(title, forKey: "title")
                updatingData.setValue(body, forKey: "body")
                updatingData.setValue(todoDate, forKey: "todoDate")
            }
            updatingData.setValue(state.rawValue, forKey: "state")
            
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteDate(id: UUID) {
        guard let context = appDelegate?.persistentContainer.viewContext else { return }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "TodoModel")
        fetchRequest.predicate = NSPredicate(format: "id = %@", id as CVarArg)
        
        do {
            let test = try context.fetch(fetchRequest)
            guard let objectDelete = test[0] as? NSManagedObject else { return }
            
            context.delete(objectDelete)
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
