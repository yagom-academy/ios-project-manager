//
//  CurrentDateFormatter.swift
//  ProjectManager
//
//  Created by Eddy on 2022/07/10.
//

import Foundation

struct CurrentDateFormatter {
    static let dateFormatter = DateFormatter()
    
    private init() {
        CurrentDateFormatter.dateFormatter.dateStyle = .long
        CurrentDateFormatter.dateFormatter.locale = .autoupdatingCurrent
    }

    static func fetch() -> Date {
        return Date(timeIntervalSinceReferenceDate: Date().timeIntervalSinceReferenceDate)
    }
}
