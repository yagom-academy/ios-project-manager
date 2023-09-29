//
//  ItemUpdatable.swift
//  ProjectManager
//
//  Created by Hemg on 2023/09/29.
//

import UIKit

protocol ItemUpdatable {
    func updateItemInArray(_ items: [ProjectManager]?, title: String, body: String, date: Date, index: Int, tableView: UITableView) -> [ProjectManager]
}

extension ItemUpdatable {
    func updateItemInArray(_ items: [ProjectManager]?, title: String, body: String, date: Date, index: Int, tableView: UITableView) -> [ProjectManager] {
        guard var mutableItems = items,
              index >= 0 && index < mutableItems.count else {
            return items ?? []
        }
        
        mutableItems[index].title = title
        mutableItems[index].body = body
        mutableItems[index].date = date
        tableView.reloadData()
        
        return mutableItems
    }
}
