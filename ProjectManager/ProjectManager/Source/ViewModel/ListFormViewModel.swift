//
//  ListFormViewModel.swift
//  ProjectManager
//  Created by inho on 2023/01/19.
//

import Foundation

final class ListFormViewModel {
    private var listItem: ListItem
    private var listType: ListType
    private var isEditable: Bool = false {
        didSet {
            editHandler?(isEditable)
        }
    }
    
    private var handler: ((ListItem) -> Void)?
    private var editHandler: ((Bool) -> Void)?
    
    init(listItem: ListItem, listType: ListType) {
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
