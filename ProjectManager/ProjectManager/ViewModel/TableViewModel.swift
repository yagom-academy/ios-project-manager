//
//  TableViewModel.swift
//  ProjectManager
//
//  Created by 강경 on 2021/06/29.
//

import UIKit

final class TableViewModel {
    private var list: [TableItem] = dummy
    
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
        dummy.remove(at: index)
    }
    
    func insert(cell: TableItem ,at index: Int) {
        list.insert(cell, at: index)
        
        // TODO: - server API "insert"
        dummy.insert(cell, at: index)
    }
}
