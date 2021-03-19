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
    
    func fetchList(_ list: [Thing]) {
        self.list = list
    }
    
    func createThing(title: String, description: String?, date: Double) {
        let thing = Thing(id: 0, title: title, description: description, dateNumber: date, state: Strings.todoState)
        NetworkManager.create(thing: thing) { result in
            switch result {
            case .success(_):
                self.list.append(thing)
            default:
                break
            }
        }
    }
    
    func updateThing(_ thing: Thing, index: Int) {
        NetworkManager.update(thing: thing) { result in
            switch result {
            case .success(_):
                self.list[index] = thing
            default:
                break
            }
        }
    }
    
    func deleteThing(at indexPath: IndexPath, id: Int?) {
        guard let id = id else {
            return
        }
        NetworkManager.delete(id: id) { result in
            switch result {
            case .success(_):
                self.list.remove(at: indexPath.row)
            default:
                break
            }
        }
    }
    
    func removeThing(at indexPath: IndexPath) {
        list.remove(at: indexPath.row)
    }
    
    func insertThing(_ thing: Thing, at indexPath: IndexPath) {
        NetworkManager.update(thing: thing) { result in
            switch result {
            case .success(_):
                self.list.insert(thing, at: indexPath.row)
            default:
                break
            }
        }
    }
    
    //MARK: - set Count
    
    func setCount(_ count: Int) {
        if let tableHeaderView = self.tableHeaderView as? ThingTableHeaderView {
            tableHeaderView.setCount(count)
        }
    }
    
}
