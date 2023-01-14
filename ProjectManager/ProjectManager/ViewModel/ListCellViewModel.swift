//
//  ListCellViewModel.swift
//  ProjectManager
//
//  Created by 맹선아 on 2023/01/13.
//

import Foundation

struct ListCellViewModel {
    
    let title: String?
    let description: String?
    let date: String
    
    init(project: Project) {
        self.title = project.title
        self.description = project.description
        self.date = project.date.dotFormat()
    }
    
    var isMissDeadLine: Bool {
        let today = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy. M. d."
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        
        guard let deadLine = dateFormatter.date(from: self.date) else { return false }
        print("today: \(today)")
        print("dead: \(deadLine)")
        return deadLine < today
    }
}
