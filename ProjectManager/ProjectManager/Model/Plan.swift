//
//  Plan.swift
//  ProjectManager
//
//  Created by Gundy on 2023/01/11.
//

import Foundation

protocol Plan {
    var title: String? { get set }
    var description: String? { get set }
    var deadline: Date? { get set }
}

struct ToDo: Plan {
    var title: String?
    var description: String?
    var deadline: Date?
}
