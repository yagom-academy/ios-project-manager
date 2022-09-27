//
//  HistoryLog.swift
//  ProjectManager
//
//  Created by 수꿍, 휴 on 2022/09/27.
//

import Foundation

struct HistoryLog: Hashable {
    var content: String
    var time: Date

    init(
        content: String,
        time: Date
    ) {
        self.content = content
        self.time = time
    }
}
