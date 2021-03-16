//
//  Droppable.swift
//  ProjectManager
//
//  Created by 임성민 on 2021/03/12.
//

import UIKit
import MobileCoreServices

protocol Droppable: ThingTableView {
    func drop(_ dropItems: [UITableViewDropItem], to indexPath: IndexPath, tableViewTitle: String)
}

extension Droppable {
    func drop(_ dropItems: [UITableViewDropItem], to indexPath: IndexPath, tableViewTitle: String) {
        guard let dropItem = dropItems.first else {
            return
        }
        
        dropItem.dragItem.itemProvider.loadDataRepresentation(forTypeIdentifier: kUTTypeJSON as String) { data, error in
            guard error == nil, let data = data, var thing = try? JSONDecoder().decode(Thing.self, from: data) else {
                return
            }
            if self.title == TableViewType.done.rawValue {
                thing.isDone = true
            } else {
                thing.isDone = false
            }
            self.insertThing(thing, at: indexPath)
            HistoryManager.insertMoveHistoryWhenInsert(to: tableViewTitle)
        }
    }
}
