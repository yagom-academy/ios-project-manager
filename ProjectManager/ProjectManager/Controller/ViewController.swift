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

    private let jsonDataManager: JSONDataManageable? = JSONDataManager()
    
    enum HeaderType {
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
        toDoTableView.register(Header.self, forHeaderFooterViewReuseIdentifier: HeaderType.toDo.identifier)
        toDoTableView.delegate = self
        
        doingTableView.dataSource = self
        doingTableView.dragDelegate = self
        doingTableView.dropDelegate = self
        doingTableView.dragInteractionEnabled = true
        doingTableView.register(Header.self, forHeaderFooterViewReuseIdentifier: HeaderType.doing.identifier)
        doingTableView.delegate = self
        
        doneTableView.dataSource = self
        doneTableView.dragDelegate = self
        doneTableView.dropDelegate = self
        doneTableView.dragInteractionEnabled = true
        doneTableView.register(Header.self, forHeaderFooterViewReuseIdentifier: HeaderType.done.identifier)
        doneTableView.delegate = self
    }
}

// MARK:- UITableView DataSource

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    //TODO
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let jsonDataManager = jsonDataManager else { return 0 }
        
        switch tableView {
        case toDoTableView:
            return jsonDataManager.toDoList.count
        case doingTableView:
            return jsonDataManager.doingList.count
        case doneTableView:
            return jsonDataManager.doneList.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let jsonDataManager = jsonDataManager else { return UITableViewCell() }
        
        switch tableView {
        case toDoTableView:
            guard let toDoCell = tableView.dequeueReusableCell(withIdentifier: "toDoCell", for: indexPath) as? ToDoTableViewCell else { return UITableViewCell() }
            
            toDoCell.configure(tasks: jsonDataManager.toDoList, rowAt: indexPath.row)
            return toDoCell
            
        case doingTableView:
            guard let doingCell = tableView.dequeueReusableCell(withIdentifier: "doingCell", for: indexPath) as? DoingTableViewCell else { return  UITableViewCell() }
            doingCell.configure(tasks: jsonDataManager.doingList, rowAt: indexPath.row)
            return doingCell
            
        case doneTableView:
            guard let doneCell = tableView.dequeueReusableCell(withIdentifier: "doneCell", for: indexPath) as? DoneTableViewCell else { return  UITableViewCell() }
            doneCell.configure(tasks: jsonDataManager.doneList, rowAt: indexPath.row)
            return doneCell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        switch tableView {
        case toDoTableView:
            return customizeHeaderView(in: tableView, withIdentifier: HeaderType.toDo.identifier)
            
        case doingTableView:
            return customizeHeaderView(in: tableView, withIdentifier: HeaderType.doing.identifier)
            
        case doneTableView:
            return customizeHeaderView(in: tableView, withIdentifier: HeaderType.done.identifier)
            
        default:
            return nil
        }
    }
    
    private func customizeHeaderView(in tableView: UITableView, withIdentifier identifier: String) -> Header? {
        let customizedHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: identifier) as? Header ?? nil
        customizedHeader?.title.text = identifier
        return customizedHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }

}

// MARK:- UITableView DragDelegate

// FIXME:- 분기처리
extension ViewController: UITableViewDragDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        
        guard let jsonDataManager = JSONDataManager() else { return [] }
        
        switch tableView {
        case toDoTableView:
            let dragItem = UIDragItem(itemProvider: NSItemProvider(object: jsonDataManager.toDoList[indexPath.row]))
            dragItem.localObject = String.self
            return [dragItem]
        case doingTableView:
            let dragItem = UIDragItem(itemProvider: NSItemProvider(object: jsonDataManager.doingList[indexPath.row]))
            dragItem.localObject = String.self
            return [dragItem]
        case doneTableView:
            let dragItem = UIDragItem(itemProvider: NSItemProvider(object: jsonDataManager.doneList[indexPath.row]))
            dragItem.localObject = String.self
            return [dragItem]
        default:
            return []
        }
    }
    
    func tableView(_ tableView: UITableView, dragSessionWillBegin session: UIDragSession) {
        
        let location = session.location(in: tableView)
        guard let indexPath = tableView.indexPathForRow(at: location) else { return }

        guard var jsonDataManager = jsonDataManager else { return }

        switch tableView {
        case toDoTableView:
            jsonDataManager.toDoList.remove(at: indexPath.row)
        case doingTableView:
            jsonDataManager.doingList.remove(at: indexPath.row)
        case doneTableView:
            jsonDataManager.doneList.remove(at: indexPath.row)
        default:
            break
        }

        tableView.deleteRows(at: [indexPath], with: .automatic)
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

        guard var jsonDataManager = jsonDataManager else { return }
        
        coordinator.session.loadObjects(ofClass: Task.self) { [weak self] tasks in
            
            guard let self = self else { return }
            
            guard let tasks = tasks as? [Task] else { return }
            
            
            var indexPaths = [IndexPath]()
            print("성공!")
            for (index, value) in tasks.enumerated() {
                let indexPath = IndexPath(row: destinationIndexPath.row + index, section: destinationIndexPath.section)
                
                switch tableView {
                case self.toDoTableView:
                    jsonDataManager.toDoList.insert(value, at: indexPath.row)
                    if jsonDataManager.doingList.contains(value) {
                        jsonDataManager.doingList = jsonDataManager.doingList.filter {$0 != value}
//                        self.doingTableView.reloadData()
                    } else {
                        jsonDataManager.doneList = jsonDataManager.doneList.filter {$0 != value}
//                        self.doneTableView.reloadData()
                    }
                case self.doingTableView:
                    jsonDataManager.doingList.insert(value, at: indexPath.row)
                    if jsonDataManager.toDoList.contains(value) {
                        jsonDataManager.toDoList = jsonDataManager.toDoList.filter {$0 != value}
//                        self.toDoTableView.reloadData()
                    } else {
                        jsonDataManager.doneList = jsonDataManager.doneList.filter {$0 != value}
//                        self.doneTableView.reloadData()
                    }
                case self.doneTableView:
                    jsonDataManager.doneList.insert(value, at: indexPath.row)
                    if jsonDataManager.doingList.contains(value) {
                        jsonDataManager.doingList = jsonDataManager.doingList.filter {$0 != value}
//                        self.doingTableView.reloadData()
                    } else {
                        jsonDataManager.toDoList = jsonDataManager.toDoList.filter {$0 != value}
//                        self.toDoTableView.reloadData()
                    }
                default:
                    break
                }
                indexPaths.append(indexPath)
            }
            tableView.insertRows(at: indexPaths, with: .automatic)
            tableView.reloadData()
        }
        
    }
    
    func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: NSString.self)
    }
}
