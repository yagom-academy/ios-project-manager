//
//  HistoryViewModel.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/26.
//

import RxCocoa
import RxRelay

struct HistoryViewModel {
    private let history: BehaviorRelay<[HistoryEntity]> = {
        return ProjectUseCase().readHistory()
    }()
    
    func read() -> Driver<[HistoryEntity]> {
        return history
            .map { $0.sorted { compare(lhs: $0, rhs: $1) } }
            .asDriver(onErrorJustReturn: [])
    }
    
    private func compare(lhs: HistoryEntity, rhs: HistoryEntity) -> Bool {
        guard let lhs = DateFormatter().formatted(string: lhs.date)?.timeIntervalSince1970,
              let rhs = DateFormatter().formatted(string: rhs.date)?.timeIntervalSince1970 else {
            return false
        }
        
        return lhs > rhs
    }
}
