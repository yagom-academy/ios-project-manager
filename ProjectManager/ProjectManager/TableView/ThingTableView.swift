//
//  ThingTableView.swift
//  ProjectManager
//
//  Created by 임성민 on 2021/03/17.
//

import UIKit

class ThingTableView: UITableView, Draggable, Droppable {
    
    //MARK: - Property
    
    var list: [Thing] = []
    
    //MARK: - Init
    
    init() {
        super.init(frame: .zero, style: .grouped)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: - CRUD
    
    func updateThing(_ thing: Thing, _ title: String, _ description: String, _ date: Int) {
        thing.title = title
        thing.detailDescription = description
        thing.dateNumber = Int64(date)
        do {
            try CoreDataStack.shared.persistentContainer.viewContext.save()
        } catch {
            
        }
    }
    
    // TODO: 통신할때 드래그에 대한 예외처리 추가.
    func deleteThing(at indexPath: IndexPath) {
        let thing = list.remove(at: indexPath.row)
        CoreDataStack.shared.persistentContainer.viewContext.delete(thing)
        do {
            try CoreDataStack.shared.persistentContainer.viewContext.save()
        } catch {
            
        }
    }
    
    func insertThing(_ thing: Thing, at indexPath: IndexPath) {
        list.insert(thing, at: indexPath.row)
        switch self {
        case is TodoTableView:
            thing.state = "todo"
        case is DoingTableView:
            thing.state = "doing"
        case is DoneTableView:
            thing.state = "done"
        default:
            break
        }
        do {
            try CoreDataStack.shared.persistentContainer.viewContext.save()
        } catch {
            
        }
    }
    
    //MARK: - set Count
    
    func setCount(_ count: Int) {
        if let tableHeaderView = self.tableHeaderView as? ThingTableHeaderView {
            tableHeaderView.setCount(count)
        }
    }
    
}
