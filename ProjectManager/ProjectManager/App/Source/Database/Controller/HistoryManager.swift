//
//  HistoryManager.swift
//  ProjectManager
//
//  Created by Harry, KokkiLE on 2023/05/29.
//

import Foundation
import Combine

final class HistoryManager {
    static let shared = HistoryManager()
    
    var historyList: [History] = [] {
        didSet {
            if historyList.count > 7 {
                historyList.removeFirst()
            }
        }
    }
    
    private init() {}
    
    func createAddedHistory(title: String) {
        let title = "Added '\(title)'."
        let history = History(title: title)
        
        historyList.append(history)
    }
    
    func createMovedHistory(title: String, from currentState: TaskState, to targetState: TaskState) {
        let title = "Moved '\(title)' from \(currentState.description) to \(targetState.description)."
        let history = History(title: title)
        
        historyList.append(history)
    }
    
    func createRemovedHistory(title: String, from state: TaskState) {
        let title = "Removed '\(title)' from \(state.description)."
        let history = History(title: title)
        
        historyList.append(history)
    }
}
