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
    
    func createData(thing: Thing) {
        todoList.insert(thing, at: 0)
        NotificationCenter.default.post(name: Notification.Name(TableViewType.todo.rawValue), object: nil)
    }
    
    func updateData(thing: Thing, tableViewType: TableViewType, index: Int) {
        switch tableViewType {
        case .todo:
            todoList[index] = thing
        case .doing:
            doingList[index] = thing
        case .done:
            doneList[index] = thing
        }
        NotificationCenter.default.post(name: Notification.Name(tableViewType.rawValue), object: nil)
    }
    
    func deleteData(tableViewType: TableViewType, index: Int) {
        switch tableViewType {
        case .todo:
            todoList.remove(at: index)
        case .doing:
            doingList.remove(at: index)
        case .done:
            doneList.remove(at: index)
        }
        NotificationCenter.default.post(name: Notification.Name(tableViewType.rawValue), object: nil)
    }
    
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
        let todo = todoList[indexPath.row]
        let itemProvider = makeThingItemProvider(todo) {
            self.todoList.remove(at: indexPath.row)
            DispatchQueue.main.async {
                tableView.reloadData()
            }
        }
        return [UIDragItem(itemProvider: itemProvider)]
    }
    
    func dragDoing(for indexPath: IndexPath, tableView: UITableView) -> [UIDragItem] {
        let doing = doingList[indexPath.row]
        let itemProvider = makeThingItemProvider(doing) {
            self.doingList.remove(at: indexPath.row)
            DispatchQueue.main.async {
                tableView.reloadData()
            }
        }
        return [UIDragItem(itemProvider: itemProvider)]
    }
    
    func dragDone(for indexPath: IndexPath, tableView: UITableView) -> [UIDragItem] {
        let done = doneList[indexPath.row]
        let itemProvider = makeThingItemProvider(done) {
            self.doneList.remove(at: indexPath.row)
            DispatchQueue.main.async {
                tableView.reloadData()
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
                self.todoList.insert(thing, at: destinationIndexPath.row)
                DispatchQueue.main.async {
                    tableView.reloadData()
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
                self.doingList.insert(thing, at: destinationIndexPath.row)
                DispatchQueue.main.async {
                    tableView.reloadData()
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
                self.doneList.insert(thing, at: destinationIndexPath.row)
                DispatchQueue.main.async {
                    tableView.reloadData()
                }
            }
        }
    }
}
