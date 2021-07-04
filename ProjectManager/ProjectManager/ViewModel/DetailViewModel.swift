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
    
    private func removeCell(at index: Int) {
        // TODO: - server API "remove"
        todoDummy.remove(at: index)
    }
    
    func insert(cell: TableItem ,at index: Int = todoDummy.endIndex) {
        // TODO: - server API "insert"
        todoDummy.insert(cell, at: index)
    }
    
    func edit(cell: TableItem ,at index: Int) {
        removeCell(at: index)
        insert(cell: cell, at: index)
    }
}
