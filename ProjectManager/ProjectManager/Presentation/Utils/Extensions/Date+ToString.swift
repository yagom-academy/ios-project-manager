//
//  Date+ToString.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/07.
//

import Foundation

extension Date {
    var toString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy. MM. d"
        return dateFormatter.string(from: self)
    }
}
