//
//  DateConverter.swift
//  ProjectManager
//
//  Created by 김태형 on 2021/04/13.
//

import Foundation

struct DateConverter {
    
    static func convertToLocaleDate(_ unixTimestamp: Double) -> String {
        let dateFormatter = DateFormatter()
        let date = Date(timeIntervalSince1970: unixTimestamp)
        dateFormatter.locale = Locale.autoupdatingCurrent
        dateFormatter.dateFormat = "yyyy. MM. dd"
        let dateString = dateFormatter.string(from: date)
        
        return dateString
    }
}
