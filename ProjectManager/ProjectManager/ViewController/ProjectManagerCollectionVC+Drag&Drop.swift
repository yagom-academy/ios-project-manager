//
//  ProjectManagerCollectionVC+Drag&Drop.swift
//  ProjectManager
//
//  Created by 김동빈 on 2021/03/15.
//

import Foundation
import UIKit

extension ProjectManagerCollectionViewController: UITableViewDragDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let table = tableView as? ListTableView
        let dragItems = table?.dragItem(tableView: tableView, indexPath: indexPath) ?? []
        return dragItems
    }
}

extension ProjectManagerCollectionViewController: UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        let table = tableView as? ListTableView
        table?.dropItem(tableView: tableView, coordinator: coordinator)
    }
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
    }
    
    func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {
        session.canLoadObjects(ofClass: NSString.self)
    }
}
