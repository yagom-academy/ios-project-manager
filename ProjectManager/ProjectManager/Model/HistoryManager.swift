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

    static func insertRemoveHistory(title: String, from: String) {
        let content = "Remove '\(title)' from \(from)"
        let dateString = DateFormatter.convertToUserLocaleStringWithTime(date: Date())
        let history: History = (content, dateString)
        list.insert(history, at: 0)
    }
    
    static func insertMoveHistoryWhenRemove(title: String, from: String) {
        let content = "Move '\(title)' from \(from)"
        let history: History = (content, String.empty)
        list.insert(history, at: 0)
    }
    
    static func insertMoveHistoryWhenInsert(to: String) {
        list[0].content = list[0].content + " to \(to)"
        list[0].dateString = DateFormatter.convertToUserLocaleStringWithTime(date: Date())
    }
}
