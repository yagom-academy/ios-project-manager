//
//  TodoModel.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/09.
//

import Foundation

struct TodoModel: Hashable {
    var category: Category
    var title: String
    var body: String
    var date: Date
}
