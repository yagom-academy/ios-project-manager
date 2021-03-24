//
//  ThingTableView.swift
//  ProjectManager
//
//  Created by 임성민 on 2021/03/17.
//

import UIKit

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
    
    func updateThing(_ thing: Thing, title: String, description: String, date: Double) {
        thing.title = title
        thing.detailDescription = description
        thing.dateNumber = date
        do {
            try CoreDataStack.shared.persistentContainer.viewContext.save()
        } catch {
            debugPrint("core data error")
        }
    }
    
    func deleteThing(at indexPath: IndexPath) {
        let thing = list[indexPath.row]
        let id = thing.id
        list.remove(at: indexPath.row)
        CoreDataStack.shared.persistentContainer.viewContext.delete(thing)
        do {
            try CoreDataStack.shared.persistentContainer.viewContext.save()
            NetworkManager.delete(id: Int(id)) { _ in }
        } catch {
            debugPrint("core data error")
        }
    }
    
    func removeThing(at indexPath: IndexPath) {
        list.remove(at: indexPath.row)
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
