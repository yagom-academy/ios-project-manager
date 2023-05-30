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
    private let realmManager = RealmManager()
    
    var historyList: [History] = [] {
        didSet {
            removeHistoryIfNeeded()
        }
    }
    
    private init() {
        fetch()
    }
    
    private func fetch() {
        guard let realmList = realmManager.readAll(type: RealmHistory.self) else { return }
        
        historyList = realmList.map { History($0) }
    }
    
    func createAddedHistory(title: String) {
        let title = "Added '\(title)'."
        let history = History(title: title)
        let realmHistory = RealmHistory(title: title)
        
        historyList.append(history)
        realmManager.create(realmHistory)
    }
    
    func createMovedHistory(title: String, from currentState: TaskState, to targetState: TaskState) {
        let title = "Moved '\(title)' from \(currentState.description) to \(targetState.description)."
        let history = History(title: title)
        let realmHistory = RealmHistory(title: title)
        
        historyList.append(history)
        realmManager.create(realmHistory)
    }
    
    func createRemovedHistory(title: String, from state: TaskState) {
        let title = "Removed '\(title)' from \(state.description)."
        let history = History(title: title)
        let realmHistory = RealmHistory(title: title)
        
        historyList.append(history)
        realmManager.create(realmHistory)
    }
    
    private func removeHistoryIfNeeded() {
        if historyList.count > 7 {
            let history = historyList.removeFirst()
            
            realmManager.delete(type: RealmHistory.self, id: history.id)
        }
    }
}
