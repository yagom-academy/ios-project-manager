//
//  Schedule.swift
//  ProjectManager
//
//  Created by 이승재 on 2022/03/04.
//

import Foundation

struct Schedule {
    var title: String
    var body: String
    var dueDate: Date
    var progress: Progress
}

enum Progress {
    case todo
    case doing
    case done
}
