//
//  HistoryViewModel.swift
//  ProjectManager
//
//  Created by 김민성 on 2023/10/04.
//

import SwiftUI

final class HistoryViewModel: ObservableObject {
    
    let historyUseCases: HistoryUseCases
    
    @Published var historyList: [History] = []
    
    init(useCases: HistoryUseCases) {
        self.historyUseCases = useCases
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
        self.historyList = historyUseCases.fetchHistoryList()
    }
    
    enum HistoryType {
        case added
        case moved(destination: TaskState)
        case removed
    }
}
