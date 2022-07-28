//
//  HistoryViewModel.swift
//  ProjectManager
//
//  Created by 두기 on 2022/07/27.
//

import RxRelay

protocol HistoryViewModelable: HistoryViewModelInput, HistoryViewModelOutput {}

protocol HistoryViewModelInput {}

protocol HistoryViewModelOutput {
    var hitory: BehaviorRelay<[History]> { get }
}

final class HistoryViewModel: HistoryViewModelable {
    init(history: [History]) {
        self.hitory = BehaviorRelay<[History]>(value: history)
    }
    
    //out
    var hitory: BehaviorRelay<[History]>
}
