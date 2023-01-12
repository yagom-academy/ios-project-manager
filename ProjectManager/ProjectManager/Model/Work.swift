//
//  Work.swift
//  ProjectManager
//
//  Created by leewonseok on 2023/01/12.
//

import Foundation

struct Work {
    let id = UUID()
    var category: Category
    var title: String
    var body: String
    var endDate: String
}
