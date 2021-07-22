//
//  ViewController+DragDelegate.swift
//  ProjectManager
//
//  Created by 이영우 on 2021/07/22.
//

import UIKit

extension ViewController: UITableViewDragDelegate {
    
    func tableView(_ tableView: UITableView,
                   itemsForBeginning session: UIDragSession,
                   at indexPath: IndexPath) -> [UIDragItem] {
        let task: Task
        if tableView == todoTableView {
            task = todoTasks[indexPath.row]
        } else if tableView == doingTableView {
            task = doingTasks[indexPath.row]
        } else {
            task = doneTasks[indexPath.row]
        }
        
        session.localContext = DragCoordinator(indexPath: indexPath)
        let itemProvider = NSItemProvider(object: task)
        return [UIDragItem(itemProvider: itemProvider)]
    }
    
    func tableView(_ tableView: UITableView, dragSessionDidEnd session: UIDragSession) {
        guard let dragCoordinator = session.localContext as? DragCoordinator else { return }
        if tableView == todoTableView {
            todoTasks.remove(at: dragCoordinator.indexPath.row)
        } else if tableView == doingTableView {
            doingTasks.remove(at: dragCoordinator.indexPath.row)
        } else {
            doneTasks.remove(at: dragCoordinator.indexPath.row)
        }
        tableView.performBatchUpdates{
            tableView.deleteRows(at: [dragCoordinator.indexPath], with: .automatic)
        }
    }
}
