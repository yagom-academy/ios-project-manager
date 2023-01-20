//
//  Work.swift
//  ProjectManager
//
//  Created by leewonseok on 2023/01/12.
//

import Foundation

struct Work: Equatable {
    let id: UUID
    let category: Category
    let title: String?
    let body: String?
    let endDate: Date
    
    init(id: UUID = UUID(), category: Category, title: String?, body: String?, endDate: Date) {
        self.id = id
        self.category = category
        self.title = title
        self.body = body
        self.endDate = endDate
    }
    
    var endDateToString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY. MM. dd"
        return dateFormatter.string(from: endDate)
    }
}
