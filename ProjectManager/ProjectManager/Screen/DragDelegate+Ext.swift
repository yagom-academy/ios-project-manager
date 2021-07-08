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
        let cellData = data[indexPath.section]
        
        let itemProvider = NSItemProvider(item: data, typeIdentifier: kUTTypePlainText as String)
//        let itemProvider = NSItemProvider(object: cellData, typeIdentifier: kUTTypePlainText as String)
        
        itemProvider.registerDataRepresentation(forTypeIdentifier: kUTTypeData as String, visibility: .all) { completion in
            completion(cellData, nil)
            return nil
        }
        
//        let dateProvider = NSItemProvider()
//
//        dateProvider.registerDataRepresentation(forTypeIdentifier: kUTTypePlainText as String, visibility: .all) { completion in
//            completion(date, nil)
//            return nil
//        }
//
//        let descriptionProvider = NSItemProvider()
//
//        descriptionProvider.registerDataRepresentation(forTypeIdentifier: kUTTypePlainText as String, visibility: .all) { completion in
//            completion(description, nil)
//            return nil
//        }

        return [
            UIDragItem(itemProvider: itemProvider),
//            UIDragItem(itemProvider: dateProvider),
//            UIDragItem(itemProvider: descriptionProvider)
        ]
    }
}
