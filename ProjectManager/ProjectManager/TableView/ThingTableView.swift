//
//  ThingTableView.swift
//  ProjectManager
//
//  Created by 임성민 on 2021/03/17.
//

import UIKit
import CoreData

class ThingTableView: UITableView, Draggable, Droppable {
    
    //MARK: - Property
    
    var list: [Thing] = [] {
        didSet {
            DispatchQueue.main.async {
                self.reloadData()
            }
        }
    }
    
    //MARK: - Init
    
    init() {
        super.init(frame: .zero, style: .grouped)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: - CRUD
    
    func updateThing(_ thing: Thing, title: String, description: String, date: Double, lastModified: Double) {
        thing.title = title
        thing.detailDescription = description
        thing.dateNumber = date
        thing.lastModified = lastModified
        NetworkManager.update(thing: thing) { result in
            do {
                try CoreDataStack.shared.persistentContainer.viewContext.save()
            } catch {
                debugPrint("core data error")
            }
        }
    }
    
    func deleteThing(at indexPath: IndexPath) {
        let thing = list[indexPath.row]
        let id = thing.id
        list.remove(at: indexPath.row)
        
        if NetworkMonitor.shared.isConnected {
            NetworkManager.delete(id: Int(id)) { result in
                switch result {
                case .success(_):
                    CoreDataStack.shared.persistentContainer.viewContext.delete(thing)
                case .failure(_):
                    thing.lastModified = Date().now.timeIntervalSince1970
                    thing.id = (id * -1)
                }
                do {
                    try CoreDataStack.shared.persistentContainer.viewContext.save()
                } catch {
                    debugPrint("Core Data Error")
                }
            }
        } else {
            thing.lastModified = Date().now.timeIntervalSince1970
            thing.id = (id * -1)
            do {
                try CoreDataStack.shared.persistentContainer.viewContext.save()
            } catch {
                debugPrint("Core Data Error")
            }
        }
    }
    
    func insertThing(_ thing: Thing, at indexPath: IndexPath) {
        do {
            try CoreDataStack.shared.persistentContainer.viewContext.save()
            NetworkManager.update(thing: thing) { _ in }
            list.insert(thing, at: indexPath.row)
        } catch {
            debugPrint("core data error")
        }
    }
    
    //MARK: - set Count
    
    func setCount(_ count: Int) {
        if let tableHeaderView = self.tableHeaderView as? ThingTableHeaderView {
            tableHeaderView.setCount(count)
        }
    }
    
}

// MARK: - NSFetchedResultsControllerDelegate

extension ThingTableView: NSFetchedResultsControllerDelegate {
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
