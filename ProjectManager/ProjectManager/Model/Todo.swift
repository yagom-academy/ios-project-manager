//
//  Model.swift
//  ProjectManager
//
//  Created by kaki, 릴라 on 2023/05/17.
//

import Foundation

struct Todo: Identifiable {
    var id = UUID()
    var title: String
    var body: String
    var date: String
}
