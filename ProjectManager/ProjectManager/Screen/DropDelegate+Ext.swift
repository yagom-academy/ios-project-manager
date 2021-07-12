//
//  DropDelegate+Ext.swift
//  ProjectManager
//
//  Created by kio on 2021/07/08.
//

import UIKit
import MobileCoreServices

extension ProjectManagerViewController: UITableViewDropDelegate {
    
    func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {
        return canHandle(session)
    }
    
    func canHandle(_ session: UIDropSession) -> Bool {
        print("Hi")
        return session.canLoadObjects(ofClass: CellData.self)
    }
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        
        var dropProposal = UITableViewDropProposal(operation: .cancel)
        print(dropProposal)
        guard session.items.count == 1 else { return dropProposal }
        
        if tableView.hasActiveDrag {
            dropProposal = UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        } else {
            dropProposal = UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        
        return dropProposal
    }
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        let destinationIndexPath: IndexPath
        
        let currentTableView = distinguishedTableView(currentTableView: tableView)
        
        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            let section = tableView.numberOfSections - 1
            let row = tableView.numberOfRows(inSection: section)
            destinationIndexPath = IndexPath(row: row , section: section)
        }
        
        coordinator.session.loadObjects(ofClass: CellData.self) { items in

            let stringItems = items as! [CellData]
            
            var indexPaths = [IndexPath]()
            for (index, item) in stringItems.enumerated() {
                let indexPath = IndexPath(row: destinationIndexPath.row + index, section: destinationIndexPath.section)
                
                self.addItem(currentTableView: tableView, item, at: indexPath.row)
                
                self.reorderTableView(item: item, indexPath: indexPath, currentTableView: currentTableView)
                
                indexPaths.append(indexPath)
            }
            tableView.insertRows(at: indexPaths, with: .automatic)
        }
    }
}
