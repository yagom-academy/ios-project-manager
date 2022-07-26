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
            .map { $0.sorted { $0.date > $1.date } }
            .asDriver(onErrorJustReturn: [])
    }
}
