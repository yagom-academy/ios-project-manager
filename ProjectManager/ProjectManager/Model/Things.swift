//
//  Things.swift
//  ProjectManager
//
//  Created by 임성민 on 2021/03/09.
//

import UIKit
import MobileCoreServices

final class Things {
    var todoList: [Thing] = []
    var doingList: [Thing] = []
    var doneList: [Thing] = []
    static let shared = Things()
    private init() {}
    
    private func makeThingItemProvider(_ thing: Thing, _ completionHandler: @escaping () -> Void) -> NSItemProvider {
        let data = try? JSONEncoder().encode(thing)
        let itemProvider = NSItemProvider()
        itemProvider.registerDataRepresentation(forTypeIdentifier: kUTTypeJSON as String, visibility: .all) { (completion) -> Progress? in
            completion(data, nil)
            completionHandler()
            return nil
        }
        return itemProvider
    }
    
    func dragTodo(for indexPath: IndexPath, tableView: UITableView) -> [UIDragItem] {
        let todo = todoList[indexPath.section]
        let itemProvider = makeThingItemProvider(todo) {
            self.todoList.remove(at: indexPath.section)
            let indexSet = IndexSet(indexPath.section...indexPath.section)
            DispatchQueue.main.async {
                tableView.deleteSections(indexSet, with: .automatic)
            }
        }
        return [UIDragItem(itemProvider: itemProvider)]
    }
    
    func dragDoing(for indexPath: IndexPath, tableView: UITableView) -> [UIDragItem] {
        let doing = doingList[indexPath.section]
        let itemProvider = makeThingItemProvider(doing) {
            self.doingList.remove(at: indexPath.section)
            let indexSet = IndexSet(indexPath.section...indexPath.section)
            DispatchQueue.main.async {
                tableView.deleteSections(indexSet, with: .automatic)
            }
        }
        return [UIDragItem(itemProvider: itemProvider)]
    }
    
    func dragDone(for indexPath: IndexPath, tableView: UITableView) -> [UIDragItem] {
        let done = doneList[indexPath.section]
        let itemProvider = makeThingItemProvider(done) {
            self.doneList.remove(at: indexPath.section)
            let indexSet = IndexSet(indexPath.section...indexPath.section)
            DispatchQueue.main.async {
                tableView.deleteSections(indexSet, with: .automatic)
            }
        }
        return [UIDragItem(itemProvider: itemProvider)]
    }
    
    func dropTodo(_ dropItems: [UITableViewDropItem], tableView: UITableView, destinationIndexPath: IndexPath) {
        guard let dropItem = dropItems.first else {
            return
        }
        
        dropItem.dragItem.itemProvider.loadDataRepresentation(forTypeIdentifier: kUTTypeJSON as String) { (data, error) in
            guard error == nil,
                  let data = data else {
                return
            }
            if let thing = try? JSONDecoder().decode(Thing.self, from: data) {
                self.todoList.insert(thing, at: destinationIndexPath.section)
                let indexSet = IndexSet(destinationIndexPath.section...destinationIndexPath.section)
                DispatchQueue.main.async {
                    tableView.insertSections(indexSet, with: .automatic)
                }
            }
        }
    }
    
    func dropDoing(_ dropItems: [UITableViewDropItem], tableView: UITableView, destinationIndexPath: IndexPath) {
        guard let dropItem = dropItems.first else {
            return
        }
        
        dropItem.dragItem.itemProvider.loadDataRepresentation(forTypeIdentifier: kUTTypeJSON as String) { (data, error) in
            guard error == nil,
                  let data = data else {
                return
            }
            if let thing = try? JSONDecoder().decode(Thing.self, from: data) {
                self.doingList.insert(thing, at: destinationIndexPath.section)
                let indexSet = IndexSet(destinationIndexPath.section...destinationIndexPath.section)
                DispatchQueue.main.async {
                    tableView.insertSections(indexSet, with: .automatic)
                }
            }
        }
    }
    
    func dropDone(_ dropItems: [UITableViewDropItem], tableView: UITableView, destinationIndexPath: IndexPath) {
        guard let dropItem = dropItems.first else {
            return
        }
        
        dropItem.dragItem.itemProvider.loadDataRepresentation(forTypeIdentifier: kUTTypeJSON as String) { (data, error) in
            guard error == nil,
                  let data = data else {
                return
            }
            if let thing = try? JSONDecoder().decode(Thing.self, from: data) {
                self.doneList.insert(thing, at: destinationIndexPath.section)
                let indexSet = IndexSet(destinationIndexPath.section...destinationIndexPath.section)
                DispatchQueue.main.async {
                    tableView.insertSections(indexSet, with: .automatic)
                }
            }
        }
    }
}
