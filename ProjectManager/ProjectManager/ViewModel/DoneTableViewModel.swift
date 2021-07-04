//
//  DoneTableViewModel.swift
//  ProjectManager
//
//  Created by 강경 on 2021/07/04.
//

import Foundation

final class DoneTableViewModel: TableViewModel {
    internal var list: [TableItem] = doneDummy
    
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
        doneDummy.remove(at: index)
    }
    
    func insert(cell: TableItem ,at index: Int) {
        list.insert(cell, at: index)
        
        // TODO: - server API "insert"
        doneDummy.insert(cell, at: index)
    }
}
