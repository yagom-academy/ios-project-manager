//
//  Draggable.swift
//  ProjectManager
//
//  Created by 임성민 on 2021/03/12.
//

import UIKit

protocol Draggable: ThingTableView {
    func drag(for indexPath: IndexPath) -> [UIDragItem]
}

extension Draggable {
    func drag(for indexPath: IndexPath) -> [UIDragItem] {
        let thing = list[indexPath.row]
        let data = try? JSONEncoder().encode(thing)
        let itemProvider = NSItemProvider.makeJSONItemProvider(data: data) {
            self.deleteThing(at: indexPath)
        }
        let dragItem = UIDragItem(itemProvider: itemProvider)
        return [dragItem]
    }
}
