//
//  ScheduleHistoryUseCase.swift
//  ProjectManager
//
//  Created by Lee Seung-Jae on 2022/03/22.
//

import Foundation
import RxSwift

final class ScheduleHistoryUseCase {

    // MARK: - Properties

    private let bag = DisposeBag()
    private let scheduleHistoryProvider: ScheduleHistoryRepository

    // MARK: - Initializer

    init(historyRepository: ScheduleHistoryRepository ) {
        self.scheduleHistoryProvider = historyRepository
//        self.binding()
    }

    // MARK: - Methods

    func recodeHistory(action: ScheduleAction) {
        self.scheduleHistoryProvider.excuteAndRecode(action: action)
    }

    func undo() {
        self.scheduleHistoryProvider.undo()
    }

    func redo() {
        self.scheduleHistoryProvider.redo()
    }
}

