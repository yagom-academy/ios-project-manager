//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var toDoTableView: UITableView!
    @IBOutlet weak var doingTableView: UITableView!
    @IBOutlet weak var doneTableView: UITableView!

    enum header {
        case toDo, doing, done
        
        var identifier: String {
            switch self {
            case .toDo:
                return "TODO"
            case .doing:
                return "DOING"
            case .done:
                return "DONE"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toDoTableView.dataSource = self
        toDoTableView.dragDelegate = self
        toDoTableView.dropDelegate = self
        toDoTableView.dragInteractionEnabled = true
        toDoTableView.register(Header.self, forHeaderFooterViewReuseIdentifier: header.toDo.identifier)
        toDoTableView.delegate = self
        
        doingTableView.dataSource = self
        doingTableView.dragDelegate = self
        doingTableView.dropDelegate = self
        doingTableView.dragInteractionEnabled = true
        doingTableView.register(Header.self, forHeaderFooterViewReuseIdentifier: header.doing.identifier)
        doingTableView.delegate = self
        
        doneTableView.dataSource = self
        doneTableView.dragDelegate = self
        doneTableView.dropDelegate = self
        doneTableView.dragInteractionEnabled = true
        doneTableView.register(Header.self, forHeaderFooterViewReuseIdentifier: header.done.identifier)
        doneTableView.delegate = self
    }
}

// MARK:- UITableView DataSource

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    //TODO
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch tableView {
        case toDoTableView:
            guard let toDoCell = tableView.dequeueReusableCell(withIdentifier: "toDoCell", for: indexPath) as? ToDoTableViewCell else { return UITableViewCell() }
            toDoCell.configure(tasks: toDoTask, rowAt: indexPath.row)
            return toDoCell
            
        case doingTableView:
            guard let doingCell = tableView.dequeueReusableCell(withIdentifier: "doingCell", for: indexPath) as? DoingTableViewCell else { return  UITableViewCell() }
            doingCell.configure(tasks: doingTask, rowAt: indexPath.row)
            return doingCell
            
        case doneTableView:
            guard let doneCell = tableView.dequeueReusableCell(withIdentifier: "doneCell", for: indexPath) as? DoneTableViewCell else { return  UITableViewCell() }
            doneCell.configure(tasks: doneTask, rowAt: indexPath.row)
            return doneCell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        switch tableView {
        case toDoTableView:
            return customizeHeaderView(in: tableView, withIdentifier: header.toDo.identifier)
            
        case doingTableView:
            return customizeHeaderView(in: tableView, withIdentifier: header.doing.identifier)
            
        case doneTableView:
            return customizeHeaderView(in: tableView, withIdentifier: header.done.identifier)
            
        default:
            return nil
        }
    }
    
    private func customizeHeaderView(in tableView: UITableView, withIdentifier identifier: String) -> Header? {
        let customizedHeader = toDoTableView.dequeueReusableHeaderFooterView(withIdentifier: identifier) as? Header ?? nil
        customizedHeader?.title.text = identifier
        return customizedHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }

}

// MARK:- UITableView DragDelegate
extension ViewController: UITableViewDragDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let dragItem = UIDragItem(itemProvider: NSItemProvider(object: self.toDoTask[indexPath.row]))
        dragItem.localObject = true
        return [dragItem]
    }

}

// MARK:- UITableView DropDelegate
extension ViewController: UITableViewDropDelegate {
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        if session.localDragSession != nil {
            return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        return UITableViewDropProposal(operation: .cancel, intent: .unspecified)
    }
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        let destinationIndexPath: IndexPath
        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            let section = tableView.numberOfSections - 1
            let row = tableView.numberOfRows(inSection: section)
            destinationIndexPath = IndexPath(row: row, section: section)
        }
        //FIXME:- NSString.self -> Task.self
        coordinator.session.loadObjects(ofClass: Task.self) { tasks in
            guard let tasks = tasks as? [Task] else { return }
            var indexPaths = [IndexPath]()
            print("성공!")
            for (index, value) in tasks.enumerated() {
                let indexPath = IndexPath(row: destinationIndexPath.row + index, section: destinationIndexPath.section)
                switch tableView {
                case self.toDoTableView:
                    self.toDoTask.insert(value, at: indexPath.row)
                    if (self.doingTask.contains(value)) {
                        self.doingTask = self.doingTask.filter {$0 != value}
                        self.doingTableView.reloadData()
                    } else {
                        self.doneTask = self.doneTask.filter {$0 != value}
                        self.doneTableView.reloadData()
                    }
                case self.doingTableView:
                    self.doingTask.insert(value, at: indexPath.row)
                    if (self.toDoTask.contains(value)) {
                        self.toDoTask = self.toDoTask.filter {$0 != value}
                        self.toDoTableView.reloadData()
                    } else {
                        self.doneTask = self.doneTask.filter {$0 != value}
                        self.doneTableView.reloadData()
                    }
                case self.doneTableView:
                    self.doneTask.insert(value, at: indexPath.row)
                    if (self.doingTask.contains(value)) {
                        self.doingTask = self.doingTask.filter {$0 != value}
                        self.doingTableView.reloadData()
                    } else {
                        self.toDoTask = self.toDoTask.filter {$0 != value}
                        self.toDoTableView.reloadData()
                    }
                default:
                    break
                }
                indexPaths.append(indexPath)
            }
            tableView.insertRows(at: indexPaths, with: .automatic)
        }
        
    }
    
    func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: NSString.self)
    }
}
