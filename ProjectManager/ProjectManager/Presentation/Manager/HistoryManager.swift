//
//  HistoryManager.swift
//  ProjectManager
//
//  Created by 김민성 on 2023/10/05.
//

import SwiftUI

final class HistoryManager: ObservableObject {
    let historyUseCases: HistoryUseCases
    
    @Published var historyList: [History]
    @Published var isHistoryOn: Bool = false
    
    init(historyUseCases: HistoryUseCases) {
        self.historyUseCases = historyUseCases
        self.historyList = historyUseCases.fetchHistoryList()
    }
    
    func save(type: HistoryType, task: Task) {
        let history = makeHistory(type: type, task: task)
        historyUseCases.saveHistory(history)
        fetchAll()
    }
    
    private func makeHistory(type: HistoryType, task: Task) -> History {
        switch type {
        case .added:
            return History(title: "Added '\(task.title)'")
        case .moved(let destination):
            return History(title: "Moved '\(task.title) from \(task.state.title) to \(destination.title)")
        case .removed:
            return History(title: "Removed '\(task.title) from \(task.state.title)")
        }
    }
    
    func fetchAll() {
        historyList = historyUseCases.fetchHistoryList()
    }
    
    func setHistoryVisible(_ isVisible: Bool) {
        isHistoryOn = isVisible
    }
    
    enum HistoryType {
        case added
        case moved(destination: TaskState)
        case removed
    }
}
