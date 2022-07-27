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
        
        let capturedOriginalTask = Task(
            title: task.title,
            body: task.body,
            date: task.date,
            taskType: task.taskType,
            id: task.id
        )
        
        let capturedChangedTask = Task(
            title: task.title,
            body: task.body,
            date: task.date,
            taskType: taskType,
            id: task.id
        )
        registerChangeUndoAction(task: capturedChangedTask, targetType: beforeType)
        
        do {
            try realmManager.change(task: task, targetType: taskType)
            
            sendNotificationForHistory(task.title, from: beforeType, to: task.taskType)
            dismiss.accept(())
        } catch {
            self.error.accept(DatabaseError.changeError)
        }
    }
    
    private func registerChangeUndoAction(task: Task, targetType: TaskType) {
        let capturedOriginalTask = Task(
            title: task.title,
            body: task.body,
            date: task.date,
            taskType: task.taskType,
            id: task.id
        )
        let capturedChangedTask = Task(
            title: task.title,
            body: task.body,
            date: task.date,
            taskType: targetType,
            id: task.id
        )
        
        let beforeType = capturedOriginalTask.taskType
        
        undoManager.registerUndo(withTarget: self) { [weak self] _ in
            self?.registerChangeRedoAction(task: capturedChangedTask, targetType: beforeType)
            do {
                try self?.realmManager.change(task: task, targetType: targetType)
                self?.sendNotificationForHistory()
            } catch {
                self?.error.accept(DatabaseError.changeError)
            }
        }
    }
    
    private func registerChangeRedoAction(task: Task, targetType: TaskType) {
        let capturedOriginalTask = Task(
            title: task.title,
            body: task.body,
            date: task.date,
            taskType: task.taskType,
            id: task.id
        )
        
        let capturedChangedTask = Task(
            title: task.title,
            body: task.body,
            date: task.date,
            taskType: targetType,
            id: task.id
        )
        
        let beforeTask = capturedOriginalTask.taskType
        
        undoManager.registerUndo(withTarget: self) { [weak self] _ in
            self?.registerChangeUndoAction(task: capturedChangedTask, targetType: beforeTask)
            do {
                try self?.realmManager.change(task: task, targetType: targetType)
                self?.sendNotificationForHistory(
                    capturedOriginalTask.title,
                    from: capturedOriginalTask.taskType,
                    to: targetType
                )
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
