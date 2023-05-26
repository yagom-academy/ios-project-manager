//
//  ProjectDateFormatter.swift
//  ProjectManager
//
//  Created by 김성준 on 2023/05/26.
//

import Foundation

final class ProjectDateFormatter {
    private let dateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        
        return dateFormatter
    }()
    
    static let shared = ProjectDateFormatter()
    
    private init() { }
    
    lazy var nowDate = {
        return self.formatDate(date: Date())
    }()
    
    
    func formatDate(date: Date) -> Date? {
        let formattedDate = dateFormatter.string(from: date)
        
        return dateFormatter.date(from: formattedDate)
    }
    
    func convertToDate(text: String) -> Date? {
        let date = dateFormatter.date(from: text)
        
        return date
        
    }
}
