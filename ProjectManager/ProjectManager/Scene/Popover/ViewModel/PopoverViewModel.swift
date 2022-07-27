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
        
        let capturedTask = Task(
            title: task.title,
            body: task.body,
            date: task.date,
            taskType: task.taskType,
            id: task.id
        )
        
        registerChangeUndoAction(task: capturedTask, taskType: taskType)
        
        do {
            try realmManager.change(task: task, targetType: taskType)
            
            sendNotificationForHistory(task.title, from: beforeType, to: task.taskType)
            dismiss.accept(())
        } catch {
            self.error.accept(DatabaseError.changeError)
        }
    }
    
    private func registerChangeUndoAction(task: Task, taskType: TaskType) {
        let capturedOriginalTask = Task(
            title: task.title,
            body: task.body,
            date: task.date,
            taskType: task.taskType,
            id: task.id
        )
        
//        let capturedEditedTask = Task(
//            title: task.title,
//            body: task.body,
//            date: task.date,
//            taskType: taskType,
//            id: task.id
//        )
        let beforeTask = capturedOriginalTask.taskType
        
        undoManager.registerUndo(withTarget: self) { [weak self] _ in
            self?.registerChangeRedoAction(task: capturedOriginalTask, taskType: taskType)
            do {
                try self?.realmManager.change(task: task, targetType: beforeTask)
                self?.sendNotificationForHistory()
            } catch {
                self?.error.accept(DatabaseError.changeError)
            }
        }
    }
    
    private func registerChangeRedoAction(task: Task, taskType: TaskType) {
        let capturedOriginalTask = Task(
            title: task.title,
            body: task.body,
            date: task.date,
            taskType: task.taskType,
            id: task.id
        )
        
        let capturedEditedTask = Task(
            title: task.title,
            body: task.body,
            date: task.date,
            taskType: taskType,
            id: task.id
        )
        
        undoManager.registerUndo(withTarget: self) { [weak self] _ in
            self?.registerChangeUndoAction(task: capturedEditedTask, taskType: capturedOriginalTask.taskType)
            do {
                try self?.realmManager.change(task: capturedEditedTask, targetType: capturedOriginalTasktaskType)
                self?.sendNotificationForHistory(capturedOriginalTask.title, from: capturedOriginalTask.taskType, to: taskType)
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
