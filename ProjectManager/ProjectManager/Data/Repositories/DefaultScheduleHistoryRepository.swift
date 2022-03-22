//
//  DefaultScheduleHistoryRepository.swift
//  ProjectManager
//
//  Created by Lee Seung-Jae on 2022/03/22.
//

import Foundation

class DefaultScheduleHistoryRepository: ScheduleHistoryRepository {
    let undoManager = UndoManager()
    var history = [ScheduleAction]()

    var canUndo: Bool {
        self.undoManager.canUndo
    }

    var canRedo: Bool {
        self.undoManager.canRedo
    }

    func undo() {
        guard canUndo else { return }
        self.undoManager.undo()
    }

    func redo() {
        guard canRedo else { return }
        self.undoManager.redo()
    }

    func registerUndoFor(action: ScheduleAction) {
        undoManager.registerUndo(withTarget: self) { target in
            action.isUndone = true
            action.reverse()
            target.registerRedoFor(action: action)
        }
    }

    func registerRedoFor(action: ScheduleAction) {
        undoManager.registerUndo(withTarget: self) { target in
            action.isUndone = false
            action.execute()
            target.registerUndoFor(action: action)
        }
    }

    func excuteAndRecode(action: ScheduleAction) {
        history = Array(history.drop { $0.isUndone })
        history = [action] + history
        registerUndoFor(action: action)

        action.execute()
    }

}
