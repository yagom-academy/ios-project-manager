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
        NetworkManager().patchData(
            type: tableViewType,
            data: cell,
            id: cell.id
        ) {}
    }
}
