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
        
        let sourceTableViewData = distinguishedTableViewData(currentTableView: tableView)
        let cellData = sourceTableViewData[indexPath.row]
        cellData.sourceTableViewIndexPath = indexPath
        let itemProvider = NSItemProvider(object: cellData)
        
        return [UIDragItem(itemProvider: itemProvider)]
    }

//    func dragItems(for indexPath: IndexPath) -> [UIDragItem] {
//        let cellData = todoTableViewData[indexPath.row]
//        let itemProvider = NSItemProvider(object: cellData)
//        let itemProvider = NSItemProvider(object: cellData, typeIdentifier: kUTTypePlainText as String)
//        
//        itemProvider.registerDataRepresentation(forTypeIdentifier: kUTTypeData as String, visibility: .) { completion in
//            completion(cellData, nil)
//            return nil
//        }

//        return [UIDragItem(itemProvider: itemProvider)]
//    }
}
