//
//  TodoTableVIew.swift
//  ProjectManager
//
//  Created by 임성민 on 2021/03/17.
//

import UIKit
import CoreData

final class TodoTableView: ThingTableView {
    
    private lazy var fetchedResultsController: NSFetchedResultsController<Thing> = {
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Thing> = NSFetchRequest<Thing>(entityName: "Thing")
        fetchRequest.predicate = NSPredicate(format: "state = 'todo'")
        let sort = NSSortDescriptor(key: #keyPath(Thing.dateNumber), ascending: false)
        fetchRequest.sortDescriptors = [sort]
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        return fetchedResultsController
    }()
    
    override init() {
        super.init()
        tableHeaderView = ThingTableHeaderView(height: 50, title: Strings.todoTitle)
        fetch()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        tableHeaderView = ThingTableHeaderView(height: 50, title: Strings.todoTitle)
    }
    
    func createThing(_ title: String, _ description: String, _ date: Int) {
        let thing = Thing(context: CoreDataStack.shared.persistentContainer.viewContext)
        thing.id = 0
        thing.title = title
        thing.detailDescription = description
        thing.dateNumber = Int64(date)
        thing.state = Strings.todoState
        do {
            try CoreDataStack.shared.persistentContainer.viewContext.save()
            NetworkManager.create(thing: thing) { _ in }
            list.insert(thing, at: 0)
        } catch {
            
        }
    }
    
    private func fetch() {
        do {
            try fetchedResultsController.performFetch()
        } catch {
            
        }
        if let fetchedObjects = fetchedResultsController.fetchedObjects {
            self.list = fetchedObjects
            self.reloadData()
        }
    }
}

extension TodoTableView: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete, .insert, .update:
            self.reloadData()
        default:
            break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.reloadData()
    }
}
