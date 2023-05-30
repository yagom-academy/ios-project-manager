//
//  HistoryViewModel.swift
//  ProjectManager
//
//  Created by Harry, KokkiLE on 2023/05/29.
//

import Foundation

final class HistoryViewModel {
    private let historyManager = HistoryManager.shared
    let historyList: [History]
    
    init() {
        historyList = historyManager.historyList
    }
}
