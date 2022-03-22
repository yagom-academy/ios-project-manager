//
//  ScheduleHistoryUseCase.swift
//  ProjectManager
//
//  Created by Lee Seung-Jae on 2022/03/22.
//

import Foundation
import RxSwift

final class ScheduleHistoryUseCase: ScheduleHistoryManageUseCase, ScheduleActionRecodeUseCase {

    // MARK: - Properties

    private let bag = DisposeBag()
    private let scheduleHistoryProvider: ScheduleHistoryRepository

    // MARK: - Initializer

    init(historyRepository: ScheduleHistoryRepository) {
        self.scheduleHistoryProvider = historyRepository
    }

    // MARK: - Methods

    func fetch() -> Observable<[ScheduleAction]> {
        return self.scheduleHistoryProvider.fetch()
    }

    func checkCanUndo() -> Observable<Bool> {
        return self.scheduleHistoryProvider.checkCanUndo()
    }

    func checkCanRedo() -> Observable<Bool> {
        return self.scheduleHistoryProvider.checkCanRedo()
    }

    func recode(action: ScheduleAction) {
        self.scheduleHistoryProvider.recode(action: action)
    }

    func undo() {
        self.scheduleHistoryProvider.undo()
    }

    func redo() {
        self.scheduleHistoryProvider.redo()
    }
}
