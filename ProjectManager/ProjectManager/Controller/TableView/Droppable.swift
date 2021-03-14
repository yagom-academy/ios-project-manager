//
//  Droppable.swift
//  ProjectManager
//
//  Created by 임성민 on 2021/03/12.
//

import UIKit
import MobileCoreServices

protocol Droppable: UITableView {
    func drop(_ dropItems: [UITableViewDropItem], to indexPath: IndexPath)
}

extension Droppable where Self: ThingTableView {
    func drop(_ dropItems: [UITableViewDropItem], to indexPath: IndexPath) {
        guard let dropItem = dropItems.first else {
            return
        }
        
        dropItem.dragItem.itemProvider.loadDataRepresentation(forTypeIdentifier: kUTTypeJSON as String) { (data, error) in
            guard error == nil,
                  let data = data else {
                return
            }
            guard let thing = try? JSONDecoder().decode(Thing.self, from: data) else {
                return
            }
            
            let index = indexPath.row
            Things.shared.insertThing(thing, at: index, self.tableViewType)
            DispatchQueue.main.async {
                self.insertRows(at: [indexPath], with: .fade)
            }
        }
    }
}
