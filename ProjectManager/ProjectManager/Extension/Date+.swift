//
//  Date+.swift
//  ProjectManager
//
//  Created by Gundy on 2023/01/11.
//

import Foundation

extension Date {
    var isOverdue: Bool {
        return Date() > self
    }
}
