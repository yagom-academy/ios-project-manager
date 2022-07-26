//
//  HistoryViewModel.swift
//  ProjectManager
//
//  Created by 김동욱 on 2022/07/22.
//

import RxCocoa
import RxRelay

final class HistoryViewModel {
    let historyData: Driver<[History]>
    
    private let database: DatabaseManagerProtocol?
    
    init(database: DatabaseManagerProtocol) {
        self.database = database
        
        self.historyData = database.updateBehaviorRelay
            .map { $0.reversed() }
            .asDriver(onErrorJustReturn: [])
    }
}
