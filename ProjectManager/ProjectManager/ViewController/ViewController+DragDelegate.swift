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
        
        let itemProvider = NSItemProvider(object: task)
        return [UIDragItem(itemProvider: itemProvider)]
    }
}
