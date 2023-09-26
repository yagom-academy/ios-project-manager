//
//  Dateformatter+.swift
//  ProjectManager
//
//  Created by idinaloq on 2023/09/26.
//

import Foundation

extension DateFormatter {
    static let dateFormatter: DateFormatter = DateFormatter()
    static var tody: String {
        let date: Date = Date(timeIntervalSinceNow: 0)
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.timeZone = TimeZone(identifier: TimeZone.current.identifier)
        dateFormatter.dateStyle = .long
        
        return dateFormatter.string(from: date)
    }
}
