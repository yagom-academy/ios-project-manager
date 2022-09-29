//
//  ItemListCategory.swift
//  ProjectManager
//
//  Created by brad, bard on 2022/09/15.
//

import Foundation

struct ItemListCategory: Codable {
    
    // MARK: - Properties
    
    let todo: [ToDoItem]
    let doing: [ToDoItem]
    let done: [ToDoItem]
    
    // MARK: - Initializers
    
    init(todo: [ToDoItem] = [], doing: [ToDoItem] = [], done: [ToDoItem] = []) {
        self.todo = todo
        self.doing = doing
        self.done = done
    }
    
    // MARK: - CodingKey
    
    enum CodingKeys: String, CodingKey {
        case todo = "TODO"
        case doing = "DOING"
        case done = "DONE"
    }
}
