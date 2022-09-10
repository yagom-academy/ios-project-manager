//
//  Date + Extension.swift
//  ProjectManager
//
//  Created by brad, bard on 2022/09/10.
//

import Foundation

// MARK: - Extentions

extension Date {
    func formatDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy. MM. dd"
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = TimeZone(abbreviation: "KST")
        
        return formatter.string(from: self)
    }
}
