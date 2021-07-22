//
//  ViewController+DropDelegate.swift
//  ProjectManager
//
//  Created by 이영우 on 2021/07/22.
//

import UIKit

extension ViewController: UITableViewDropDelegate {
//    func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {
//        return session.canLoadObjects(ofClass: Task.self)
//    }

    func tableView(_ tableView: UITableView,
                   dropSessionDidUpdate session: UIDropSession,
                   withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        guard session.localDragSession != nil else {
            return UITableViewDropProposal(operation: .copy, intent: .insertAtDestinationIndexPath)
        }
        guard session.items.count == 1 else { return UITableViewDropProposal(operation: .cancel) }
        
        return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
    }
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        let destinationIndexPath: IndexPath
//        var tasks: [Task]
//
//        if tableView == todoTableView {
//            tasks = todoTasks
//        } else if tableView == doingTableView {
//            tasks = doingTasks
//        } else {
//            tasks = doneTasks
//        }
        
        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            destinationIndexPath = IndexPath(row: tableView.numberOfRows(inSection: 0), section: 0)
        }
        
        let item = coordinator.items[0]
        switch coordinator.proposal.operation {
        case .move:
            guard let dragCoordinator = coordinator.session.localDragSession?.localContext as? DragCoordinator else {
                return
            }
            if let sourceIndexPath = item.sourceIndexPath {
                //같은 테이블뷰일때
                dragCoordinator.isReordering = true
                if tableView == todoTableView {
                    let task = todoTasks[sourceIndexPath.row]
                    todoTasks.remove(at: sourceIndexPath.row)
                    todoTasks.insert(task, at: destinationIndexPath.row)
                } else if tableView == doingTableView {
                    let task = doingTasks[sourceIndexPath.row]
                    doingTasks.remove(at: sourceIndexPath.row)
                    doingTasks.insert(task, at: destinationIndexPath.row)
                } else {
                    let task = doneTasks[sourceIndexPath.row]
                    doneTasks.remove(at: sourceIndexPath.row)
                    doneTasks.insert(task, at: destinationIndexPath.row)
                }
                tableView.performBatchUpdates {
//                    let task = tasks[sourceIndexPath.row]
//                    tasks.remove(at: sourceIndexPath.row)
//                    tasks.insert(task, at: destinationIndexPath.row)
                    tableView.deleteRows(at: [sourceIndexPath], with: .automatic)
                    tableView.insertRows(at: [destinationIndexPath], with: .automatic)
                }
            } else {
                //다른 테이블뷰일때
                dragCoordinator.isReordering = false
                if let task = item.dragItem.localObject as? Task {
                    if tableView == todoTableView {
                        todoTasks.insert(task, at: destinationIndexPath.row)
                    } else if tableView == doingTableView {
                        doingTasks.insert(task, at: destinationIndexPath.row)
                    } else {
                        doneTasks.insert(task, at: destinationIndexPath.row)
                    }
                    tableView.performBatchUpdates {
                        tableView.insertRows(at: [destinationIndexPath], with: .automatic)
                    }
                }
            }
            dragCoordinator.dragCompleted = true
            coordinator.drop(item.dragItem, toRowAt: destinationIndexPath)
        default:
            return
        }
    }
}
