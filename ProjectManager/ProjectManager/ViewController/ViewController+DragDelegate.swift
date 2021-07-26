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
        let dataSource = dataSourceForTableView(tableView)
        session.localContext = DragCoordinator(indexPath: indexPath)
        return dataSource.dragItems(for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, dragSessionDidEnd session: UIDragSession) {
        guard let dragCoordinator = session.localContext as? DragCoordinator,
              dragCoordinator.dragCompleted == true,
              dragCoordinator.isReordering == false else { return }
        let dataSource = dataSourceForTableView(tableView)
        dataSource.deleteTask(at: dragCoordinator.indexPath.row)
        tableView.performBatchUpdates{
            tableView.deleteRows(at: [dragCoordinator.indexPath], with: .automatic)
        }
    }
}
