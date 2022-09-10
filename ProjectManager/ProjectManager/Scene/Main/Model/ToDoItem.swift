//
//  ToDoItem.swift
//  ProjectManager
//
//  Created by brad, bard on 2022/09/07.
//

import Foundation

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
    
    // MARK: - CodingKey

    private enum CodingKeys: CodingKey {
        
        case title
        case description
        case timeLimit
    }
}
