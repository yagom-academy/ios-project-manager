//
//  Model.swift
//  ProjectManager
//
//  Created by brad, bard on 2022/09/07.
//

import Foundation

struct ToDoItem: Hashable {
    
    private let uuid = UUID()
    
    let title: String
    
    let description: String
    
    let timeLimit: Date
}
