//
//  HistoryUseCases.swift
//  ProjectManager
//
//  Created by 김민성 on 2023/10/04.
//

final class HistoryUseCases {
    
    private let historyRepository: HistoryRepository
    
    init(historyRepository: HistoryRepository) {
        self.historyRepository = historyRepository
    }
    
    func fetchHistoryList() -> [History] {
        historyRepository.fetchAll()
    }
    
    func saveHistory(_ history: History) {
        historyRepository.save(history)
    }
}
