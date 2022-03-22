//
//  DefaultScheduleHistoryRepository.swift
//  ProjectManager
//
//  Created by Lee Seung-Jae on 2022/03/22.
//

import Foundation
import RxSwift
import RxRelay

final class DefaultScheduleHistoryRepository: ScheduleHistoryRepository {

    private let undoManager = UndoManager()
    private var history = BehaviorRelay<[ScheduleAction]>(value: [])
    private var historyCanUndo = BehaviorRelay<Bool>(value: false)
    private var historyCanRedo = BehaviorRelay<Bool>(value: false)
    private var canUndo: Bool {
        self.undoManager.canUndo
    }

    private var canRedo: Bool {
        self.undoManager.canRedo
    }

    func fetch() -> Observable<[ScheduleAction]> {
        return self.history.asObservable()
            .map { $0.filter { !$0.isUndone } }
    }

    func undo() {
        guard self.canUndo else { return }
        self.undoManager.undo()
        self.history.accept(self.history.value)
        self.historyCanUndo.accept(canUndo)
        self.historyCanRedo.accept(canRedo)
    }

    func redo() {
        guard self.canRedo else { return }
        self.undoManager.redo()
        self.history.accept(self.history.value)
        self.historyCanUndo.accept(canUndo)
        self.historyCanRedo.accept(canRedo)
    }

    func recode(action: ScheduleAction) {
        let currentHistory = self.history.value.filter { !$0.isUndone }
        let newHistory = [action] + currentHistory
        self.history.accept(newHistory)
        self.registerUndoFor(action: action)
        self.historyCanUndo.accept(canUndo)
        self.historyCanRedo.accept(canRedo)
    }

    func checkCanUndo() -> Observable<Bool> {
        return self.historyCanUndo.asObservable()
    }

    func checkCanRedo() -> Observable<Bool> {
        return self.historyCanRedo.asObservable()
    }
}

private extension DefaultScheduleHistoryRepository {

    func registerUndoFor(action: ScheduleAction) {
        self.undoManager.registerUndo(withTarget: self) { target in
            action.isUndone = true
            action.reverse()
            target.registerRedoFor(action: action)
        }
    }

    func registerRedoFor(action: ScheduleAction) {
        self.undoManager.registerUndo(withTarget: self) { target in
            action.isUndone = false
            action.execute()
            target.registerUndoFor(action: action)
        }
    }
}
