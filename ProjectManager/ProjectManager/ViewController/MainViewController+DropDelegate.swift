//
//  ViewController+DropDelegate.swift
//  ProjectManager
//
//  Created by 이영우 on 2021/07/22.
//

import UIKit

extension MainViewController: UITableViewDropDelegate {
    func tableView(_ tableView: UITableView,
                   dropSessionDidUpdate session: UIDropSession,
                   withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        guard session.items.count == 1 else {
            return UITableViewDropProposal(operation: .cancel)
        }
        return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
    }
    
    func tableView(_ tableView: UITableView,
                   performDropWith coordinator: UITableViewDropCoordinator) {
        let dataSource = dataSources(for: tableView)
        let destinationIndexPath: IndexPath
        
        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            destinationIndexPath = IndexPath(row: tableView.numberOfRows(inSection: 0), section: 0)
        }
        
        let item = coordinator.items[0]
        switch coordinator.proposal.operation {
        case .move:
            guard let dragCoordinator = coordinator.session.localDragSession?.localContext
                    as? DragCoordinator else { return }
            if let sourceIndexPath = item.sourceIndexPath {
                dragCoordinator.shouldReordering = true
                dataSource.move(from: sourceIndexPath.row, to: destinationIndexPath.row)
                tableView.moveRow(at: sourceIndexPath, to: destinationIndexPath)
            } else {
                dragCoordinator.shouldReordering = false
                if let task = item.dragItem.localObject as? Task,
                   let taskTableView = tableView as? TaskTableView {
                    task.type = taskTableView.state
                    dataSource.add(task, at: destinationIndexPath.row)
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
