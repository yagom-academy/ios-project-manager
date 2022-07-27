//
//  HistoryViewModel.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/26.
//

import RxCocoa
import RxRelay

struct HistoryViewModel {
    private let projectUseCase: ProjectUseCase

    private lazy var history: BehaviorRelay<[HistoryEntity]> = {
        return projectUseCase.readHistory()
    }()
    
    init(projectUseCase: ProjectUseCase) {
        self.projectUseCase = projectUseCase
    }
    
    mutating func read() -> Driver<[HistoryEntity]> {
        return history
            .map { $0.sorted { $0.date > $1.date } }
            .asDriver(onErrorJustReturn: [])
    }
}
