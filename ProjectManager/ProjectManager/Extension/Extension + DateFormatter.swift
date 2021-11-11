//
//  Extension + DateFormatter.swift
//  ProjectManager
//
//  Created by tae hoon park on 2021/11/02.
//

import Foundation

extension DateFormatter {
    static func convertDate(date: Date) -> String {
       let formatter = DateFormatter()
        formatter.dateFormat = "YYYY.M.d"
        return formatter.string(from: date)
    }
}
