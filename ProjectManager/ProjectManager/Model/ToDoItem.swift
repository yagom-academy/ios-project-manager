//
//  ToDoItem.swift
//  ProjectManager
//
//  Created by brad, bard on 2022/09/19.
//

import Foundation

struct ToDoItem: Codable {
    
    // MARK: - Properties
    
    private let uuid = UUID()
    let title: String
    let toDoDescription: String
    let timeLimit: Date
    
    // MARK: - Initializers
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        title = try container.decode(String.self, forKey: .title)
        toDoDescription = try container.decode(String.self, forKey: .toDoDescription)
        timeLimit = try container.decode(Date.self, forKey: .timeLimit)
    }
    
    init(title: String = "", toDoDescription: String = "", timeLimit: Date = Date()) {
        self.title = title
        self.toDoDescription = toDoDescription
        self.timeLimit = timeLimit
    }
    
    // MARK: - CodingKey

    private enum CodingKeys: CodingKey {
        
        case title
        case toDoDescription
        case timeLimit
    }
}
