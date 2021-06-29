//
//  DetailViewModel.swift
//  ProjectManager
//
//  Created by 강경 on 2021/06/30.
//

import Foundation

class DetailViewModel {
    var item: TableItem?
    
    func update(model: TableItem?) {
        item = model
    }
    
    func itemInfo() -> TableItem? {
        return item
    }
}
