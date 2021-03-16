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
        let content = String(format: Strings.historyAddMessage, title)
        let dateString = DateFormatter.convertToUserLocaleStringWithTime(date: Date())
        let history: History = (content, dateString)
        list.insert(history, at: 0)
    }
    
    static func insertRemoveHistory(title: String, from: String) {
        let content = String(format: Strings.historyDeleteMessage, title, from)
        let dateString = DateFormatter.convertToUserLocaleStringWithTime(date: Date())
        let history: History = (content, dateString)
        list.insert(history, at: 0)
    }
    
    static func insertMoveHistoryWhenRemove(title: String, from: String) {
        let content = String(format: Strings.historyStartMoveMessage, title, from)
        let history: History = (content, String.empty)
        list.insert(history, at: 0)
    }
    
    static func insertMoveHistoryWhenInsert(to: String) {
        let content = String(format: Strings.historyEndMoveMessage, list[0].content, to)
        list[0].content = content
        list[0].dateString = DateFormatter.convertToUserLocaleStringWithTime(date: Date())
    }
}
