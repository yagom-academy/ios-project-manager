//
//  CurrentDateFormatter.swift
//  ProjectManager
//
//  Created by Eddy on 2022/07/10.
//

import Foundation

struct CurrentDateFormatter {
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.locale = .autoupdatingCurrent
        
        return dateFormatter
    }()
    
    private init() {}

    static func fetch() -> Date {
        return Date(timeIntervalSinceReferenceDate: Date().timeIntervalSinceReferenceDate)
    }
}
