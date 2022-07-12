//
//  DetailViewModel.swift
//  ProjectManager
//
//  Created by 두기 on 2022/07/13.
//

import Foundation

class DetailViewModel {
    private let storage: Storegeable
    
    init(storage: Storegeable) {
        self.storage = storage
    }
    
    func creatList(listItem: ListItem) {
        storage.creatList(listItem: listItem)
    }
    
    func updateList(listItem: ListItem) {
        storage.updateList(listItem: listItem)
    }
}
