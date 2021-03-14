//
//  Draggable.swift
//  ProjectManager
//
//  Created by 임성민 on 2021/03/12.
//

import UIKit

protocol Draggable: UITableView {
    func drag(for indexPath: IndexPath) -> [UIDragItem]
}

extension Draggable where Self: ThingTableView {
    func drag(for indexPath: IndexPath) -> [UIDragItem] {
        let index = indexPath.row
        let thing = Things.shared.getThing(at: index, self.tableViewType)
        let data = try? JSONEncoder().encode(thing)
        
        let itemProvider = NSItemProvider.makeJSONItemProvider(data: data) {
            Things.shared.deleteThing(at: index, self.tableViewType) {
                DispatchQueue.main.async {
                    self.deleteRows(at: [indexPath], with: .fade)
                }
            }
        }
        let dragItem = UIDragItem(itemProvider: itemProvider)
        return [dragItem]
    }
}
