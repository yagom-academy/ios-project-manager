//
//  HistoryManager.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/21.
//

import Foundation

final class HistoryManager {
    private var histories: [History] = []
    
    func addHistory(todo: Todo, moveTarget: String = "",
                    with style: HistoryStyle) {
        var history: History = History(title: "", date: Date())
        
        switch style {
        case .added:
            history = History(
                title: "Added '\(todo.title)'.",
                date: Date()
            )
        case .moved:
            history = History(
                title: "Moved '\(todo.title)' from \(todo.category) to \(moveTarget).",
                date: Date()
            )
        case .removed:
            history = History(
                title: "Removed '\(todo.title)' from \(todo.category).",
                date: Date()
            )
        }
        histories.append(history)
    }
    
    func fetchHistories() -> [History] {
        return histories
    }
}
