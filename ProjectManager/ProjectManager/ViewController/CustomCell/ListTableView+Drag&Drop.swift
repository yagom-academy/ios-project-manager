//
//  ListCollectionViewCell+Drag&Drop.swift
//  ProjectManager
//
//  Created by 김동빈 on 2021/03/15.
//

import Foundation
import UIKit
import MobileCoreServices

extension ListTableView {
    func dragItem(tableView: UITableView, indexPath: IndexPath) -> [UIDragItem] {
        let item = ItemList.shared.getItem(statusType: statusType, index: indexPath.row)
        guard let data = try? JSONEncoder().encode(item) else { return [] }
        let itemProvider = NSItemProvider()
        let dragItem = UIDragItem(itemProvider: itemProvider)
        
        itemProvider.registerDataRepresentation(forTypeIdentifier: kUTTypePlainText as String, visibility: .all) { completion in
            completion(data, nil)
            DispatchQueue.main.async {
                ItemList.shared.removeItem(statusType: self.statusType, index: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                self.reloadHeaderCellCountLabel()
            }
            return nil
        }
        return [dragItem]
    }
    
    func dropItem(tableView: UITableView, coordinator: UITableViewDropCoordinator) {
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
                self.reloadHeaderCellCountLabel()
              }
          }
        }
    }
}
