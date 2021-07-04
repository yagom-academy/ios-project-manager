//
//  TodoTableViewModel.swift
//  ProjectManager
//
//  Created by 강경 on 2021/06/29.
//

import Foundation

final class TodoTableViewModel: TableViewModel {
    internal var list: [TableItem] = todoDummy
    
    var numOfList: Int {
        return list.count
    }
    
    func itemInfo(at index: Int) -> TableItem {
        return list[index]
    }
    
    func update(model: [TableItem]) {
        list = model
    }
    
    func removeCell(at index: Int) {
        list.remove(at: index)
        
        // TODO: - server API "remove"
        todoDummy.remove(at: index)
    }
    
    func insert(cell: TableItem ,at index: Int) {
        list.insert(cell, at: index)
        
        // TODO: - server API "insert"
        todoDummy.insert(cell, at: index)
    }
}
