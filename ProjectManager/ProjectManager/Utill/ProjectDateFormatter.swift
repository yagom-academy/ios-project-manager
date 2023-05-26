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
        dateFormatter.dateFormat = "yyyy. M. d."
        
        return dateFormatter
    }()
    
    static let shared = ProjectDateFormatter()
    
    private init() { }
    
    func formatDateText(date: Date) -> String {
        return dateFormatter.string(from: date)
    }
}
