//
//  Work.swift
//  ProjectManager
//
//  Created by leewonseok on 2023/01/12.
//

import Foundation

struct Work: Equatable {
    let id = UUID()
    let category: Category
    let title: String?
    let body: String?
    let endDate: Date
    
    var endDateToString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY. MM. dd"
        return dateFormatter.string(from: endDate)
    }
}
