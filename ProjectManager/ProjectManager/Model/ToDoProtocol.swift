//
//  ToDoProtocl.swift
//  ProjectManager
//
//  Created by goat on 2023/05/19.
//

import Foundation

protocol ToDoProtocl {
    var title: String { get set }
    var description: String { get set }
    var date: Date { get set }
}
