//
//  Date+Extension.swift
//  ProjectManager
//
//  Created by Jae-hoon Sim on 2022/03/12.
//

import Foundation

extension Date {

    var formattedDateString: String {
        return DateFormatter.dueDate.string(from: self)
    }

    var formattedHistoryDateString: String {
        return DateFormatter.historyDate.string(from: self)
    }
}
