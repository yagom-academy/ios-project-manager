//
//  ProjectModel.swift
//  ProjectManager
//
//  Created by Hamo, Wonbi on 2023/01/16.
//

import Foundation

protocol Projectable {
    var id: UUID { get }
    var title: String { get set }
    var date: Date { get set }
    var description: String { get set }
}

struct TodoProject: Projectable {
    let id: UUID = UUID()
    var title: String
    var date: Date
    var description: String
}

struct DoingProject: Projectable {
    let id: UUID = UUID()
    var title: String
    var date: Date
    var description: String
}

struct DoneProject: Projectable {
    let id: UUID = UUID()
    var title: String
    var date: Date
    var description: String
}
