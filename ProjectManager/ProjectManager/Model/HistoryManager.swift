//
//  HistoryManager.swift
//  ProjectManager
//
//  Created by 리나 on 2021/03/16.
//

import Foundation

struct HistoryManager {
    typealias History = (content: String, dateString: String)
    static var list: [History] = [] {
        didSet {
            if list.count > 10 {
                list.removeLast()
            }
        }
    }
    
    static func insertAddHistory(title: String) {
        let content = "Add '\(title)'"
        let dateString = DateFormatter.convertToUserLocaleStringWithTime(date: Date())
        let history: History = (content, dateString)
        list.insert(history, at: 0)
    }
}
