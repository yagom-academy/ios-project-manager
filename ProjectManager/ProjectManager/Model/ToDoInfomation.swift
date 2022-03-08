//
//  ToDoInfomation.swift
//  ProjectManager
//
//  Created by 서녕 on 2022/03/02.
//

import Foundation

struct ToDoInfomation {
    var id: UUID
    let title: String
    let discription: String
    let deadline: Double
    var position: ToDoPosition
    var localizedDateString: String {
        return DateFormatter().localizedDateString(from: deadline)
    }
}
