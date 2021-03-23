//
//  CoreDataStack.swift
//  ProjectManager
//
//  Created by 임성민 on 2021/03/18.
//

import CoreData
import Foundation

final class CoreDataStack {
    static let shared: CoreDataStack = CoreDataStack()
    
    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: Strings.projectManager)
        container.loadPersistentStores(completionHandler: { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func checkedOverlap() {
        guard let things = try? persistentContainer.viewContext.fetch(Thing.fetchRequest()) as? [Thing] else {
            return
        }
        var i = 0
        while i < things.count + 1 {
            var j = i + 1
            while j < things.count {
                if things[i].id == things[j].id {
                    if things[i].lastModified > things[j].lastModified {
                        things[j].title = things[i].title
                        things[j].detailDescription = things[i].detailDescription
                        things[j].dateNumber = things[i].dateNumber
                        things[j].lastModified = things[i].lastModified
                        things[j].state = things[i].state
                    }
                    NetworkManager.update(thing: things[j]) { _ in }
                    persistentContainer.viewContext.delete(things[i])
                    saveContext()
                }
                j += 1;
            }
            i += 1;
        }
    }
}
