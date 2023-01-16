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
            info.setValue(0, forKey: "state")
            info.setValue(UUID(), forKey: "id")
            
            do {
                try context?.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    // TODO: -Update
    func updateData() {
        
    }
    
    // TODO: -Delete
    func deleteDate() {
        
    }
}
