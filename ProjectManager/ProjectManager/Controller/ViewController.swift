//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {
        
    private var datasource: TaskTableViewDataSource?
    
    @IBOutlet weak var toDoTableView: UITableView!
    @IBOutlet weak var doingTableView: UITableView!
    @IBOutlet weak var doneTableView: UITableView!
    
    @IBAction func addToDoTask(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let addTaskViewController = storyboard.instantiateViewController(withIdentifier: "addTaskViewController") as? AddTaskViewController else { return }
            
        addTaskViewController.modalPresentationStyle = .automatic
        
        addTaskViewController.popoverPresentationController?.barButtonItem = sender
        addTaskViewController.delegate = self
        self.present(addTaskViewController, animated: false)
    }
    
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
        
        static var height: CGFloat {
            return 60
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datasource = TaskDataSource(toDoTableView: toDoTableView, doingTableView: doingTableView, doneTableView: doneTableView)
        
        setTableViewDelegate(tableView: toDoTableView, headerType: .toDo)
        setTableViewDelegate(tableView: doingTableView, headerType: .doing)
        setTableViewDelegate(tableView: doneTableView, headerType: .done)
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.customize(dateStyle: .medium, timeStyle: .none, dateFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ")
    }
    
    func setTableViewDelegate(tableView: UITableView, headerType: HeaderType) {
        tableView.dataSource = datasource
        tableView.dragDelegate = self
        tableView.dropDelegate = self
        tableView.dragInteractionEnabled = true
        tableView.register(HeaderView.self, forHeaderFooterViewReuseIdentifier: headerType.identifier)
        tableView.delegate = self
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
    
    private func customizeHeaderView(in tableView: UITableView, withIdentifier identifier: String) -> HeaderView? {
        let customizedHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: identifier) as? HeaderView ?? nil
        customizedHeader?.title.text = identifier
        return customizedHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return HeaderType.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

// MARK:- UITableView DragDelegate

extension ViewController: UITableViewDragDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        
        let dragCoordinator = TaskDragCoordinator(sourceIndexPath: indexPath)
        session.localContext = dragCoordinator
        
        let taskType: ProjectTaskType
        
        switch tableView {
        case toDoTableView:
            taskType = .todo
        case doingTableView:
            taskType = .doing
        case doneTableView:
            taskType = .done
        default:
            taskType = .todo
        }
        
        return datasource?.dragItem(taskType: taskType, for: indexPath) ?? []
        
    }
    
    func tableView(_ tableView: UITableView, dragSessionDidEnd session: UIDragSession) {
        guard let dragCoordinator = session.localContext as? TaskDragCoordinator,
              dragCoordinator.dragCompleted == true,
              dragCoordinator.isReordering == false
        else { return }
        
        let sourceIndexPath = dragCoordinator.sourceIndexPath
        
        datasource?.deleteTask(at: sourceIndexPath, in: tableView)
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
        
        guard let dragCoordinator =
                coordinator.session.localDragSession?.localContext as? TaskDragCoordinator
        else { return }
        
        for dropItem in coordinator.items {
            if let sourceIndexPath = dropItem.sourceIndexPath {
                dragCoordinator.isReordering = true
                datasource?.moveTask(from: sourceIndexPath, to: destinationIndexPath, in: tableView)
                coordinator.drop(dropItem.dragItem, toRowAt: destinationIndexPath)
            } else {
                dragCoordinator.isReordering = false
                if let task = dropItem.dragItem.localObject as? Task {
                    datasource?.addTask(task: task, destinationIndexPath: destinationIndexPath, tableView: tableView)
                }
            }
            dragCoordinator.dragCompleted = true
            coordinator.drop(dropItem.dragItem, toRowAt: destinationIndexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: Task.self)
    }
}

extension ViewController: ModalDelegate {
    func addToDoList(task: Task) {
        datasource?.appendToDoList(task: task)
    }
}

extension ViewController: TableViewReloadable {
    func reloadToDoTableView() {
        self.toDoTableView.reloadData()
    }
}

