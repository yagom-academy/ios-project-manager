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
        Dummy.shared.remove(
            tableViewType: tableViewType,
            at: index
        )
    }
    
    func insert(
        memo: Memo,
        at index: Int = Dummy.shared.dummyList.count,
        tableViewType: TableViewType
    ) {
        NetworkManager().postData(
            type: tableViewType,
            data: memo
        ) {}
    }
    
    func edit(
        cell: Memo,
        tableViewType: TableViewType
    ) {
        // TODO: - server API "edit"
//        removeCell(
//            at: index,
//            tableViewType: tableViewType
//        )
//        insert(
//            memo: cell,
//            at: index,
//            tableViewType: tableViewType
//        )
        NetworkManager().patchData(
            type: tableViewType,
            data: cell,
            id: cell.id
        ) {}
    }
}
