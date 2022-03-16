//
//  Date+Extension.swift
//  ProjectManager
//
//  Created by 1 on 2022/03/08.
//

import Foundation

extension Date {
    
    static let localeDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.setLocalizedDateFormatFromTemplate("yyyy.MM.dd")
        dateFormatter.locale = .autoupdatingCurrent
        return dateFormatter
    }()
    
    func localeString() -> String {
        return Date.localeDateFormatter.string(from: self)
    }
}
