//
//  Date.swift
//  ProjectManager
//
//  Created by 조민호 on 2022/07/08.
//

import Foundation

extension Date {
    var formattedString: String {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "yyyy. M. d."
        return formatter.string(from: self)
    }
}
