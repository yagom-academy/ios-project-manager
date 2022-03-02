//
//  ToDoInfomation.swift
//  ProjectManager
//
//  Created by 서녕 on 2022/03/02.
//

import Foundation

struct ToDoInfomation {
    var title: String
    var explanation: String
    var deadline: Double
    
    var localizedDeadline: String {
        return DateFormatter().localizedDateString(from: deadline)
    }
}
