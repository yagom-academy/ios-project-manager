//
//  Work.swift
//  ProjectManager
//
//  Created by leewonseok on 2023/01/12.
//

import Foundation

struct Work {
    let id = UUID()
    var category: Category
    var title: String?
    var body: String?
    var endDate: Date
    
    var endDateToString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY. MM. DD"
        return dateFormatter.string(from: endDate)
    }
}

protocol WorkDelegate: AnyObject {
    func send(data: Work)
}
