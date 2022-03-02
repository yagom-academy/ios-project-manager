//
//  DateUtil.swift
//  ProjectManager
//
//  Created by 고은 on 2022/03/02.
//

import Foundation

struct DateUtils {

    static func deadlineFormat(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"

        return dateFormatter.string(from: date)
    }

}
