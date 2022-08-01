//
//  HistoryViewModel.swift
//  ProjectManager
//
//  Created by 김동욱 on 2022/07/22.
//

import RxCocoa
import RxRelay

final class HistoryViewModel {
    private let database: DatabaseManagerProtocol?
    let historyData: Driver<[History]>

    init(database: DatabaseManagerProtocol) {
        self.database = database

        self.historyData = database.historyBehaviorRelay
            .map { $0.reversed() }
            .asDriver(onErrorJustReturn: [])
    }
}
