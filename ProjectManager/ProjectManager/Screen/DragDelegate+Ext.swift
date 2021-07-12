//
//  ProjecManagerDragDelegate+Ext.swift
//  ProjectManager
//
//  Created by kio on 2021/07/08.
//

import UIKit
import MobileCoreServices

extension ProjectManagerViewController: UITableViewDragDelegate {
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let dragItem = dragItems(for: indexPath, tableView: tableView)
        
        return dragItem
    }
}
