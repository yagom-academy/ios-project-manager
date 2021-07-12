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

    private let datasource: TaskTableViewDataSource = TaskDataSource()
    
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
        
        toDoTableView.dataSource = datasource
        toDoTableView.dragDelegate = self
        toDoTableView.dropDelegate = self
        toDoTableView.dragInteractionEnabled = true
        toDoTableView.register(Header.self, forHeaderFooterViewReuseIdentifier: HeaderType.toDo.identifier)
        toDoTableView.delegate = self
        
        doingTableView.dataSource = datasource
        doingTableView.dragDelegate = self
        doingTableView.dropDelegate = self
        doingTableView.dragInteractionEnabled = true
        doingTableView.register(Header.self, forHeaderFooterViewReuseIdentifier: HeaderType.doing.identifier)
        doingTableView.delegate = self
        
        doneTableView.dataSource = datasource
        doneTableView.dragDelegate = self
        doneTableView.dropDelegate = self
        doneTableView.dragInteractionEnabled = true
        doneTableView.register(Header.self, forHeaderFooterViewReuseIdentifier: HeaderType.done.identifier)
        doneTableView.delegate = self
        
        let date = Date()
        let dateFormatter = DateFormatter()
        
        dateFormatter.customize(dateStyle: .medium, timeStyle: .none, dateFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ")
        print(dateFormatter.string(from: date))
        print(Date().toString(dateFormat: "KST"))
    }
}

// MARK:- UITableView DataSource

extension ViewController: UITableViewDelegate {

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
        
        guard let jsonDataManager = TaskJSONDataManager() else { return [] }
        
        switch tableView {
        case toDoTableView:
            return jsonDataManager.dragItem(taskType: .todo, for: indexPath)
        case doingTableView:
            return jsonDataManager.dragItem(taskType: .doing, for: indexPath)
        case doneTableView:
            return jsonDataManager.dragItem(taskType: .done, for: indexPath)
        default:
            return []
        }
        
    }
    
    func tableView(_ tableView: UITableView, dragSessionWillBegin session: UIDragSession) {
        
        let location = session.location(in: tableView)
        guard let indexPath = tableView.indexPathForRow(at: location) else { return }

        guard var jsonDataManager = datasource else { return }

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

        guard var jsonDataManager = datasource else { return }
        
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
                    } else {
                        jsonDataManager.doneList = jsonDataManager.doneList.filter {$0 != value}
                    }
                case self.doingTableView:
                    jsonDataManager.doingList.insert(value, at: indexPath.row)
                    if jsonDataManager.toDoList.contains(value) {
                        jsonDataManager.toDoList = jsonDataManager.toDoList.filter {$0 != value}
                    } else {
                        jsonDataManager.doneList = jsonDataManager.doneList.filter {$0 != value}
                    }
                case self.doneTableView:
                    jsonDataManager.doneList.insert(value, at: indexPath.row)
                    if jsonDataManager.doingList.contains(value) {
                        jsonDataManager.doingList = jsonDataManager.doingList.filter {$0 != value}
                    } else {
                        jsonDataManager.toDoList = jsonDataManager.toDoList.filter {$0 != value}
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
        return session.canLoadObjects(ofClass: Task.self)
    }
}


