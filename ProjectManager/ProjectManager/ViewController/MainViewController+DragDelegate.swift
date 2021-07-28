//
//  ViewController+DragDelegate.swift
//  ProjectManager
//
//  Created by 이영우 on 2021/07/22.
//

import UIKit

extension MainViewController: UITableViewDragDelegate {
    func tableView(_ tableView: UITableView,
                   itemsForBeginning session: UIDragSession,
                   at indexPath: IndexPath) -> [UIDragItem] {
        let dataSource = dataSource(for: tableView)
        session.localContext = DragCoordinator(indexPath: indexPath)
        return dataSource.dragItems(for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, dragSessionDidEnd session: UIDragSession) {
        guard let dragCoordinator = session.localContext as? DragCoordinator,
              dragCoordinator.dragCompleted == true,
              dragCoordinator.shouldReordering == false else { return }
        let dataSource = dataSource(for: tableView)
        dataSource.delete(at: dragCoordinator.indexPath.row)
        tableView.performBatchUpdates {
            tableView.deleteRows(at: [dragCoordinator.indexPath], with: .automatic)
        }
    }
}
