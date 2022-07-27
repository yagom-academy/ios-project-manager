//
//  PopoverViewModel.swift
//  ProjectManager
//
//  Created by Donnie, Grumpy on 2022/07/11.
//

import Foundation
import RxRelay
import Firebase

protocol PopoverViewModelEvent {
    func moveButtonTapped(_ task: Task, to taskType: TaskType)
}

protocol PopoverViewModelState {
    var dismiss: PublishRelay<Void> { get }
}

final class PopoverViewModel: PopoverViewModelEvent, PopoverViewModelState, ErrorObservable, PopNotificationSendable {
    
    var dismiss: PublishRelay<Void> = .init()
    var error: PublishRelay<DatabaseError> = .init()
    private let undoManager = AppDelegate.undoManager
    private let realmManager = RealmManager()
    
    func moveButtonTapped(_ task: Task, to taskType: TaskType) {
        changeTaskType(task, taskType: taskType)
    }

    private func changeTaskType(_ task: Task, taskType: TaskType) {
        
        let beforeType = task.taskType
        
        let temp = Task(
            title: task.title,
            body: task.body,
            date: task.date,
            taskType: task.taskType,
            id: task.id
        )
        
        registerChangeUndoAction(task: temp, taskType: taskType)
        
        do {
            try realmManager.change(task: task, targetType: taskType)
            
            sendNotificationForHistory(task.title, from: beforeType, to: task.taskType)
            dismiss.accept(())
        } catch {
            self.error.accept(DatabaseError.changeError)
        }
    }
    
    private func registerChangeUndoAction(task: Task, taskType: TaskType) {
        let beforeType = task.taskType
        let movedTask = Task(
            title: task.title,
            body: task.body,
            date: task.date,
            taskType: taskType,
            id: task.id
        )
        undoManager.registerUndo(withTarget: self) { [weak self] _ in
            do {
                self?.registerChangeRedoAction(task: task, taskType: taskType)
                try self?.realmManager.change(task: movedTask, targetType: beforeType)
                self?.sendNotificationForHistory()
            } catch {
                self?.error.accept(DatabaseError.changeError)
            }
        }
    }
    
    private func registerChangeRedoAction(task: Task, taskType: TaskType) {
        undoManager.registerUndo(withTarget: self) { [weak self] _ in
            let movingTask = Task(
                title: task.title,
                body: task.body,
                date: task.date,
                taskType: task.taskType,
                id: task.id
            )
            let afterType = movingTask.taskType
            do {
                self?.registerChangeUndoAction(task: movingTask, taskType: taskType)
                try self?.realmManager.change(task: movingTask, targetType: taskType)
                self?.sendNotificationForHistory(movingTask.title, from: afterType, to: movingTask.taskType)
            } catch {
                self?.error.accept(DatabaseError.changeError)
            }
        }
    }
    
    private func sendNotificationForHistory(_ title: String, from beforeType: TaskType, to afterType: TaskType) {
        let content = "Moved '\(title)' from \(beforeType.rawValue) to \(afterType.rawValue)"
        let time = Date().timeIntervalSince1970
        let history: [String: Any] = ["content": content, "time": time]
        NotificationCenter.default.post(name: NSNotification.Name("PushHistory"), object: nil, userInfo: history)
    }
}
