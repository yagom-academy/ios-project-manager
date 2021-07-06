//
//  DetailViewModel.swift
//  ProjectManager
//
//  Created by 강경 on 2021/06/30.
//

import Foundation

final class DetailViewModel {
    private var item: TableItem?
    
    func update(model: TableItem?) {
        item = model
    }
    
    func itemInfo() -> TableItem? {
        return item
    }
    
    func setItem(_ item: TableItem?) {
        self.item = item
    }
    
    func tableItem() -> TableItem? {
        return item
    }
   
    private func removeCell(
        at index: Int,
        tableViewType: TableViewType
    ) {
        // TODO: - server API "remove"
        switch tableViewType {
        case .todo:
            todoDummy.remove(at: index)
        case .doing:
            doingDummy.remove(at: index)
        case .done:
            doneDummy.remove(at: index)
        }
    }
    
    func insert(
        cell: TableItem,
        at index: Int = todoDummy.endIndex,
        tableViewType: TableViewType
    ) {
        // TODO: - server API "insert"
        switch tableViewType {
        case .todo:
            todoDummy.insert(
                cell,
                at: index
            )
        case .doing:
            doingDummy.insert(
                cell,
                at: index
            )
        case .done:
            doneDummy.insert(
                cell,
                at: index
            )
        }
    }
    
    func edit(
        cell: TableItem,
        at index: Int,
        tableViewType: TableViewType
    ) {
        removeCell(
            at: index,
            tableViewType: tableViewType
        )
        insert(
            cell: cell,
            at: index,
            tableViewType: tableViewType
        )
    }
}
