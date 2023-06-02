//
//  HistoryManager.swift
//  ProjectManager
//
//  Created by 레옹아범 on 2023/05/31.
//

import Foundation

struct HistoryManager {
    private var histories: [History] = []
    
    var sortedHistories: [History] {
        return histories.sorted { $0.date > $1.date }
    }
    
    mutating func addHistory(text: String, date: Date) {
        let history = History(text: text, date: date)
        
        histories.append(history)
    }
}
