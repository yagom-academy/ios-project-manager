//
//  TableViewModel.swift
//  ProjectManager
//
//  Created by 강경 on 2021/07/04.
//

import Foundation

protocol TableViewModel {
    var list: [TableItem] { get set }
    
    var numOfList: Int { get }
    
    func itemInfo(at index: Int) -> TableItem
    
    func update(model: [TableItem])
    
    func removeCell(at index: Int)
    
    func insert(cell: TableItem ,at index: Int)
}
