//
//  Extension + Date.swift
//  ProjectManager
//
//  Created by 서현웅 on 2023/01/24.
//

import Foundation

extension Date {
    func formattedDateToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy .MM .dd"
        let stringDate = dateFormatter.string(from: self)
        return stringDate
    }
}
