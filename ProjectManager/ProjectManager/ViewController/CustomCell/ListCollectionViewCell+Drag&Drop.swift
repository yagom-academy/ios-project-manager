//
//  ListCollectionViewCell+Drag&Drop.swift
//  ProjectManager
//
//  Created by 김동빈 on 2021/03/15.
//

import Foundation
import UIKit
import MobileCoreServices

extension ListCollectionViewCell: UITableViewDragDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let item = ItemList.shared.getItem(statusType: statusType, index: indexPath.row)
        
        
        guard let data = try? JSONEncoder().encode(item) else { return [] }
        let itemProvider = NSItemProvider()
        let dragItem = UIDragItem(itemProvider: itemProvider)
        itemProvider.registerDataRepresentation(forTypeIdentifier: kUTTypePlainText as String, visibility: .all) { completion in
            completion(data, nil)
            DispatchQueue.main.async {
                ItemList.shared.removeItem(statusType: self.statusType, index: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            return nil
        }
        return [dragItem]
    }
}

extension ListCollectionViewCell: UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        let insertionIndex: IndexPath
        if let indexPath = coordinator.destinationIndexPath {
          insertionIndex = indexPath
        } else {
          let section = tableView.numberOfSections - 1
            let row = tableView.numberOfRows(inSection: section)
            insertionIndex = IndexPath(row: row, section: section)
        }
        
        for item in coordinator.items {
          item.dragItem.itemProvider.loadDataRepresentation(forTypeIdentifier: kUTTypePlainText as String) { (data, error) in
              guard let data = data, error == nil else {
                  return
              }
              guard let todo = try? JSONDecoder().decode(Todo.self, from: data) else {
                  return
              }

              DispatchQueue.main.async {
                ItemList.shared.insertItem(statusType: self.statusType, index: insertionIndex.row, item: todo)
                  tableView.insertRows(at: [insertionIndex], with: .automatic)
                  tableView.reloadData()
              }
          }
        }
    }
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
    }
    
    func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {
        session.canLoadObjects(ofClass: NSString.self)
    }
}
