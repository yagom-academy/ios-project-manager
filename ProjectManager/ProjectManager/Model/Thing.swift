//
//  Thing.swift
//  ProjectManager
//
//  Created by 리나 on 2021/03/10.
//

import Foundation

struct Thing {
    let title: String
    let body: String
    let date: Date
    var dateString: String {
        return DateFormatter().convertToUserLocaleString(date: date)
    }
}
