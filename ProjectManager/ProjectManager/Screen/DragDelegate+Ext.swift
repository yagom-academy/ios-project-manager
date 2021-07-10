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
        
        return dragItems(for: indexPath)
    }

    func dragItems(for indexPath: IndexPath) -> [UIDragItem] {
        let cellData = todoTableViewData[indexPath.section]
        let itemProvider = NSItemProvider(object: cellData)
//        let itemProvider = NSItemProvider(object: cellData, typeIdentifier: kUTTypePlainText as String)
//        
//        itemProvider.registerDataRepresentation(forTypeIdentifier: kUTTypeData as String, visibility: .) { completion in
//            completion(cellData, nil)
//            return nil
//        }

        return [UIDragItem(itemProvider: itemProvider)]
    }
}
