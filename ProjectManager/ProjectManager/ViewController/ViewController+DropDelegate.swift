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
        let dataSource = dataSourceForTableView(tableView)
        let destinationIndexPath: IndexPath
        
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
                dataSource.moveTask(at: sourceIndexPath.row, to: destinationIndexPath.row)
                tableView.performBatchUpdates {
                    tableView.deleteRows(at: [sourceIndexPath], with: .automatic)
                    tableView.insertRows(at: [destinationIndexPath], with: .automatic)
                }
            } else {
                //다른 테이블뷰일때
                dragCoordinator.isReordering = false
                if let task = item.dragItem.localObject as? Task {
                    dataSource.addTask(task, at: destinationIndexPath.row)
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
