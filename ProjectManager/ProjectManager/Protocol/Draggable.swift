//
//  Draggable.swift
//  ProjectManager
//
//  Created by 임성민 on 2021/03/12.
//

import UIKit

protocol Draggable {
    func drag(for indexPath: IndexPath) -> [UIDragItem]
}

extension Draggable where Self: ThingTableView {
    func drag(for indexPath: IndexPath) -> [UIDragItem] {
        let thing = list[indexPath.row]
        let data = try? JSONEncoder().encode(thing)
        let itemProvider = NSItemProvider.makeJSONItemProvider(data: data) {
            CoreDataStack.shared.persistentContainer.viewContext.delete(thing)
            self.list.remove(at: indexPath.row)
        }
        let dragItem = UIDragItem(itemProvider: itemProvider)
        let tableViewTitle = HistoryManager.convertTableViewToString(tableView: self)
        HistoryManager.insertMoveHistoryWhenRemove(title: thing.title, from: tableViewTitle)
        return [dragItem]
    }
}
