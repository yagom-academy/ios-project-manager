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
    private let date: Date
    var dateString: String {
        return DateFormatter().string(from: date)
    }
}
