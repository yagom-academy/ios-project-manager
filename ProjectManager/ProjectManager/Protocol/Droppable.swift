//
//  Droppable.swift
//  ProjectManager
//
//  Created by 임성민 on 2021/03/12.
//

import UIKit
import MobileCoreServices

protocol Droppable: ThingTableView {
    func drop(_ dropItems: [UITableViewDropItem], to indexPath: IndexPath, tableView: ThingTableView)
}

extension Droppable {
    func drop(_ dropItems: [UITableViewDropItem], to indexPath: IndexPath, tableView: ThingTableView) {
        guard let dropItem = dropItems.first else {
            return
        }
        
        dropItem.dragItem.itemProvider.loadDataRepresentation(forTypeIdentifier: kUTTypeJSON as String) { data, error in
            guard error == nil, let data = data, var thing = try? JSONDecoder().decode(Thing.self, from: data) else {
                return
            }
            if self is DoneTableView {
                thing.isDone = true
                thing.state = "done"
            } else if self is DoingTableView {
                thing.isDone = false
                thing.state = "doing"
            } else {
                thing.isDone = false
                thing.state = "todo"
            }
            self.insertThing(thing, at: indexPath)
            HistoryManager.insertMoveHistoryWhenInsert(to: tableView)
        }
    }
}
