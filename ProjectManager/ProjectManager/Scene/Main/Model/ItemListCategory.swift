//
//  ItemListCategory.swift
//  ProjectManager
//
//  Created by brad, bard on 2022/09/15.
//

import Foundation

struct ItemListCategory: Codable {
    
    // MARK: - Properties

    let todo, doing, done: [ToDoItem]
    
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

struct ToDoItem: Codable {
    
    // MARK: - Properties
    
    private let uuid = UUID()
    let title: String
    let description: String
    let timeLimit: Date
    
    // MARK: - Initializers
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        title = try container.decode(String.self, forKey: .title)
        description = try container.decode(String.self, forKey: .description)
        timeLimit = try container.decode(Date.self, forKey: .timeLimit)
    }
    
    init(title: String = "", description: String = "", timeLimit: Date = Date()) {
        self.title = title
        self.description = description
        self.timeLimit = timeLimit
    }
    
    // MARK: - CodingKey

    private enum CodingKeys: CodingKey {
        
        case title
        case description
        case timeLimit
    }
}
