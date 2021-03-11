//
//  Thing.swift
//  ProjectManager
//
//  Created by 임성민 on 2021/03/09.
//

import Foundation

struct Thing: Codable {
    let title: String
    let body: String
    let date: Int
    var dateString: String {
        let timeInterval = TimeInterval(date)
        let dateFormatter = DateFormatter().makeLocaleDateFormatter()
        let date = dateFormatter.string(from: Date(timeIntervalSince1970: timeInterval))
        return date
    }
}
