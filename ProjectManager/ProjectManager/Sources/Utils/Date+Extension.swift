//
//  Date+Extension.swift
//  ProjectManager
//
//  Created by Ryan-Son on 2021/07/22.
//

import Foundation

extension Date {

    var formatted: String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateStyle = .medium
        return formatter.string(from: self)
    }
}
