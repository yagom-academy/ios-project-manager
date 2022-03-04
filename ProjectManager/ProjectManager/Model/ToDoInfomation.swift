//
//  ToDoInfomation.swift
//  ProjectManager
//
//  Created by 서녕 on 2022/03/02.
//

import Foundation

struct ToDoInfomation {
    let uuid: UUID?
    var title: String
    var discription: String
    var deadline: Double
    
    var localizedDeadline: String {
        return DateFormatter().localizedDateString(from: deadline)
    }
}
