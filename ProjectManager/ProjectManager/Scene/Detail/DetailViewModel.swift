//
//  DetailViewModel.swift
//  ProjectManager
//
//  Created by 두기 on 2022/07/13.
//

import Foundation

class DetailViewModel {
    private let storage: Storegeable
    var list: ListItem
    
    init(storage: Storegeable, list: ListItem?) {
        self.storage = storage
        self.list = list ?? ListItem(title: "", body: "", deadline: Date())
    }
    
    func creatList(listItem: ListItem) {
        storage.creatList(listItem: listItem)
    }
    
    func updateList(listItem: ListItem) {
        storage.updateList(listItem: listItem)
    }
}
