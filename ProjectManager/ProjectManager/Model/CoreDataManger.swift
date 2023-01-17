//
//  CoreDataManger.swift
//  ProjectManager
//
//  Created by Baem on 2023/01/15.
//

import CoreData
import UIKit

final class CoreDataManager {
    func fetch() ->  Result<[TodoModel], CoreDataError> {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
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
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate?.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "TodoModel", in: context!)
        
        if let entity = entity {
            let info = NSManagedObject(entity: entity, insertInto: context)
            info.setValue(title, forKey: "title")
            info.setValue(body, forKey: "body")
            info.setValue(todoDate, forKey: "todoDate")
            info.setValue(State.todo.rawValue, forKey: "state")
            info.setValue(UUID(), forKey: "id")
            
            do {
                try context?.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    // TODO: -Update
    func updateData(title: String, body: String, todoDate: Date, id: UUID, state: State) {
//        let featchResults
    }
    
    func deleteDate(id: UUID) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate?.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "TodoModel")
        fetchRequest.predicate = NSPredicate(format: "id = %@", id as CVarArg)
        
        do {
            guard let test = try context?.fetch(fetchRequest) else { return }
            guard let objectDelete = test[0] as? NSManagedObject else { return }
            
            context?.delete(objectDelete)
            do {
                try context?.save()
            } catch {
                print(error.localizedDescription)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
