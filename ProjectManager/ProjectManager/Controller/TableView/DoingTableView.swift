//
//  DoingTableView.swift
//  ProjectManager
//
//  Created by 임성민 on 2021/03/17.
//

import UIKit

class DoingTableView: UITableView, ThingTableViewProtocol, Draggable, Droppable {

    //MARK: - Property
    var list: [Thing] = []
    
    //MARK: - Init
    init() {
        super.init(frame: .zero, style: .grouped)
        tableHeaderView = ThingTableHeaderView(height: 50, title: "DOING")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        tableHeaderView = ThingTableHeaderView(height: 50, title: "DOING")
    }
    
    //MARK: - CRUD
    
    func createThing(_ thing: Thing) {
        list.insert(thing, at: 0)
        self.reloadData()
    }
    
    func updateThing(_ thing: Thing, index: Int) {
        list[index] = thing
        self.reloadData()
    }
    
    func deleteThing(at indexPath: IndexPath) {
        list.remove(at: indexPath.row)
        DispatchQueue.main.async {
            self.deleteRows(at: [indexPath], with: .left)
        }
    }
    
    func insertThing(_ thing: Thing, at indexPath: IndexPath) {
        list.insert(thing, at: indexPath.row)
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    //MARK: - set Count
    
    func setCount(_ count: Int) {
        if let tableHeaderView = self.tableHeaderView as? ThingTableHeaderView {
            tableHeaderView.setCount(count)
        }
    }
}
