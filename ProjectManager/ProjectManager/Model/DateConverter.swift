//
//  DateConverter.swift
//  ProjectManager
//
//  Created by 두기 on 2022/07/08.
//

import Foundation

struct DateConverter {
    static let dateFormatter = DateFormatter()
    
    static func dateToString(_ date: Date) -> String {
        dateFormatter.locale = .autoupdatingCurrent
        dateFormatter.timeZone = .autoupdatingCurrent
        dateFormatter.dateFormat = "yyyy. M. d."
        
        let stringDate = dateFormatter.string(from: date)
        
        return stringDate
    }
}
