//
//  HistoryManager.swift
//  ProjectManager
//
//  Created by Harry, KokkiLE on 2023/05/29.
//

import Foundation
import Combine

final class HistoryManager {
    private let realmManager = RealmManager()
    private let firebaseManager = FirebaseManager()
    
    var historyList: [History] = [] {
        didSet {
            removeHistoryIfNeeded()
        }
    }
    
    init() {
        firebaseManager.addListener(History.self,
                                    createCompletion: create,
                                    deleteCompletion: delete)
    }
    
    private func fetch() {
        guard let realmList = realmManager.readAll(type: RealmHistory.self) else { return }
        
        historyList = realmList.map { History($0) }
    }
    
    func create(_ history: History) {
        guard !historyList.contains(history) else { return }
        
        historyList.append(history)
        
        let realmHistory = RealmHistory(history)
        
        realmManager.create(realmHistory)
        firebaseManager.save(history)
    }
    
    func delete(_ history: History) {
        historyList.removeAll(where: { $0.id == history.id })
        
        realmManager.delete(type: RealmHistory.self, id: history.id)
        firebaseManager.delete(type: History.self, id: history.id)
    }
    
    func getAddedHistory(title: String) -> History {
        let historyTitle = "Added '\(title)'."
        
        return History(title: historyTitle)
    }
    
    func getMovedHistory(title: String, from currentState: TaskState, to targetState: TaskState) -> History {
        let historyTitle = "Moved '\(title)' from \(currentState.description) to \(targetState.description)."
        
        return History(title: historyTitle)
    }
    
    func getRemovedHistory(title: String, from state: TaskState) -> History {
        let historyTitle = "Removed '\(title)' from \(state.description)."
        
        return History(title: historyTitle)
    }
    
    private func removeHistoryIfNeeded() {
        if historyList.count > 7 {
            let history = historyList.removeFirst()
            
            realmManager.delete(type: RealmHistory.self, id: history.id)
            firebaseManager.delete(type: History.self, id: history.id)
        }
    }
}
