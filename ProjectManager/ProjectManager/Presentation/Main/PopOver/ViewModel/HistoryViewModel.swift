//
//  HistoryViewModel.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/26.
//

import Foundation

struct HistoryViewModel {
    func read() -> [HistoryEntity] {
        let history = ProjectUseCase().readHistory()
        
        return history.sorted { compare(lhs: $0, rhs: $1) }
    }
    
    private func compare(lhs: HistoryEntity, rhs: HistoryEntity) -> Bool {
        guard let lhs = DateFormatter().formatted(string: lhs.date)?.timeIntervalSince1970,
              let rhs = DateFormatter().formatted(string: rhs.date)?.timeIntervalSince1970 else {
            return false
        }
        
        return lhs > rhs
    }
}
