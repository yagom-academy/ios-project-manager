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
    private init() {
        todoList.append(Thing(title: "titletitletitletitletitle",
                              body: """
                                    Hello World!
                                    """
                              , date: 1))
        todoList.append(Thing(title: "titletitlletitle",
                              body: """
                                    Bye World!
                                    """
                              , date: 10000000))
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
    
    func removeTodo(at index: Int, _ completionHandler: @escaping () -> Void) {
        todoList.remove(at: index) // TODO: 서버에서 정상적으로 삭제된 것이 확인되면 실행되도록 수정하기.
        completionHandler()
    }
    
    func removeDoing(at index: Int, _ completionHandler: @escaping () -> Void) {
        doingList.remove(at: index) // TODO: 서버에서 정상적으로 삭제된 것이 확인되면 실행되도록 수정하기.
        completionHandler()
    }
    
    func removeDone(at index: Int, _ completionHandler: @escaping () -> Void) {
        doneList.remove(at: index) // TODO: 서버에서 정상적으로 삭제된 것이 확인되면 실행되도록 수정하기.
        completionHandler()
    }
}
