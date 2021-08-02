//
//  TaskHistoryDelegate.swift
//  ProjectManager
//
//  Created by Fezravien on 2021/08/01.
//

import Foundation

protocol TaskHistoryDelegate {
    func updatedHistory(atTitle: String, toTitle: String, from: State)
    func addedHistory(title: String)
    func historyCount() -> Int
    func referHistory(index: IndexPath) -> TaskHistory
}
