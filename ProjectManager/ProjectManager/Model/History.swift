//
//  History.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/19.
//

import Foundation

enum HistoryStyle {
    case added
    case removed
    case moved
}

struct History {
    let title: String
    let date: Date
}
