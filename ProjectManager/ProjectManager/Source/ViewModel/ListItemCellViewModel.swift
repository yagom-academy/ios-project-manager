//
//  ListItemCellViewModel.swift
//  ProjectManager
//  Created by inho on 2023/01/17.
//

import Foundation

final class ListItemCellViewModel {
    struct ListItemData {
        var title: String
        var body: String
        var dueDate: String
        var isOverDue: Bool = false
    }
    
    private let listItem: ListItem
    private(set) var listType: ListType
    private var handler: ((ListItemData) -> Void)?
    private var listItemData: ListItemData {
        didSet {
            self.handler?(listItemData)
        }
    }
    var currentItem: ListItem {
        return listItem
    }
    
    init(listItem: ListItem, listType: ListType) {
        self.listItem = listItem
        self.listType = listType
        self.listItemData = ListItemData(
            title: listItem.title,
            body: listItem.body,
            dueDate: listItem.dueDate.convertedToString
        )
    }
    
    func bind(_ handler: @escaping (ListItemData) -> Void) {
        self.handler = handler
    }
    
    func updateItem(using updatedListItem: ListItem) {
        let compareResult = updatedListItem.dueDate.compare(listItem.dueDate)
        let updatedData = ListItemData(
            title: updatedListItem.title,
            body: updatedListItem.body,
            dueDate: updatedListItem.dueDate.convertedToString,
            isOverDue: compareResult == .orderedDescending ? true : false
        )
        
        listItemData = updatedData
    }
    
    func moveType(to newType: ListType) {
        listType = newType
    }
}
