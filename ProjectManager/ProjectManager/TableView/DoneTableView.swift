//
//  DoneTableView.swift
//  ProjectManager
//
//  Created by 임성민 on 2021/03/17.
//

import UIKit
import CoreData

final class DoneTableView: ThingTableView {
    
    private lazy var fetchedResultsController: NSFetchedResultsController<Thing> = {
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Thing> = NSFetchRequest<Thing>(entityName: Strings.thing)
        fetchRequest.predicate = NSPredicate(format: "state = 'done'")
        let sort = NSSortDescriptor(key: #keyPath(Thing.dateNumber), ascending: false)
        fetchRequest.sortDescriptors = [sort]
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        return fetchedResultsController
    }()
    
    override init() {
        super.init()
        tableHeaderView = ThingTableHeaderView(height: 50, title: Strings.doneTitle)
        fetch()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        tableHeaderView = ThingTableHeaderView(height: 50, title: Strings.doneTitle)
        fetch()
    }
    
    private func fetch() {
        do {
            try fetchedResultsController.performFetch()
        } catch {
            debugPrint("core data error")
        }
        if let fetchedObjects = fetchedResultsController.fetchedObjects {
            self.list = fetchedObjects
            self.reloadData()
        }
    }
}

extension DoneTableView: NSFetchedResultsControllerDelegate {
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

