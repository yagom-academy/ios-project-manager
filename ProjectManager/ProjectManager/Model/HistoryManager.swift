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
        let dateString = DateFormatter.convertToUserLocaleStringWithTime(date: Date().now)
        let history: History = (content, dateString)
        list.insert(history, at: 0)
    }
    
    static func insertRemoveHistory(title: String, from tableView: ThingTableView) {
        let tableView = convertTableViewToString(tableView: tableView)
        let content = String(format: Strings.historyDeleteMessage, title, tableView)
        let dateString = DateFormatter.convertToUserLocaleStringWithTime(date: Date().now)
        let history: History = (content, dateString)
        list.insert(history, at: 0)
    }
    
    static func insertMoveHistoryWhenRemove(title: String, from tableView: ThingTableView) {
        let tableView = convertTableViewToString(tableView: tableView)
        let content = String(format: Strings.historyStartMoveMessage, title, tableView)
        let history: History = (content, String.empty)
        list.insert(history, at: 0)
    }
    
    static func insertMoveHistoryWhenInsert(to tableView: ThingTableView) {
        let tableView = convertTableViewToString(tableView: tableView)
        let content = String(format: Strings.historyEndMoveMessage, list[0].content, tableView)
        list[0].content = content
        list[0].dateString = DateFormatter.convertToUserLocaleStringWithTime(date: Date().now)
    }
    
    static private func convertTableViewToString(tableView: ThingTableView) -> String {
        if tableView is TodoTableView {
            return Strings.todoTitle
        } else if tableView is DoingTableView {
            return Strings.doingTitle
        } else {
            return Strings.doneTitle
        }
    }
}
