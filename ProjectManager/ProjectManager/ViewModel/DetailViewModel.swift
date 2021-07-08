//
//  DetailViewModel.swift
//  ProjectManager
//
//  Created by 강경 on 2021/06/30.
//

import Foundation

final class DetailViewModel {
    private var item: MemoTableViewCellModel?
    
    func update(model: MemoTableViewCellModel?) {
        item = model
    }
    
    func itemInfo() -> MemoTableViewCellModel? {
        return item
    }
    
    func setItem(_ item: MemoTableViewCellModel?) {
        self.item = item
    }
    
    func tableItem() -> MemoTableViewCellModel? {
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
        cell: Memo,
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
        cell: Memo,
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
