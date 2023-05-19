//
//  DateFormatter.swift
//  ProjectManager
//
//  Created by 리지 on 2023/05/19.
//

import Foundation

final class DateFormatManager {
    static let shared = DateFormatManager()
    private init() { }
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: Locale.current.identifier)
        dateFormatter.dateFormat = "yyyy. MM. dd."
        
        return dateFormatter
    }()
    
    func convertToFormattedDate(of date: Date) -> String {
        return dateFormatter.string(from: date)
    }
}
