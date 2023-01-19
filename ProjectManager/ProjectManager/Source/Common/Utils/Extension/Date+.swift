//
//  Date+.swift
//  ProjectManager
//
//  Created by ayaan, jpush on 2023/01/19.
//

import Foundation

extension Date {
    static var startOfCurrentDay: Date {
        Calendar.current.startOfDay(for: Date())
    }
}
