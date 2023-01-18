//
//  ListFormViewModel.swift
//  ProjectManager
//  Created by inho on 2023/01/19.
//

import Foundation

final class ListFormViewModel {
    let index: Int
    private(set) var listItem: ListItem
    private(set) var listType: ListType
    private var isEditable: Bool = false {
        didSet {
            editHandler?(isEditable)
        }
    }
    
    private var editHandler: ((Bool) -> Void)?
    
    init(index: Int, listItem: ListItem, listType: ListType) {
        self.index = index
        self.listItem = listItem
        self.listType = listType
    }
    
    func bindEditHandler(_ handler: @escaping (Bool) -> Void) {
        editHandler = handler
    }
    
    func toggleEditMode() {
        isEditable.toggle()
    }
}
