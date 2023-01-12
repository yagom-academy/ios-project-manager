//
//  TodoModel.swift
//  ProjectManager
//
//  Created by 애쉬 on 2023/01/11.
//

import Foundation

struct TodoModel: Hashable {
    let id: UUID = UUID()
    var title: String = ""
    var body: String = ""
    var date: TimeInterval = 0.0
}
