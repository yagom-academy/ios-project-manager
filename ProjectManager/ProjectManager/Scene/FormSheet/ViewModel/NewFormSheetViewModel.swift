//
//  NewFormSheetViewModel.swift
//  ProjectManager
//
//  Created by Donnie, Grumpy on 2022/07/11.
//

import Foundation
import RxSwift
import RxRelay
import Firebase

protocol NewFormSheetViewModelEvent {
    func doneButtonTapped()
}

protocol NewFormSheetViewModelState {
    var title: BehaviorRelay<String> { get }
    var body: BehaviorRelay<String> { get }
    var date: BehaviorRelay<Double> { get }
    var dismiss: PublishRelay<Void> { get }
}

final class NewFormSheetViewModel: NewFormSheetViewModelEvent,
                                    NewFormSheetViewModelState,
                                    ErrorObservable,
                                    PopNotificationSendable,
                                    PushAddNotificationSendable {
    
    var title: BehaviorRelay<String> = BehaviorRelay(value: AppConstants.defaultStringValue)
    var body: BehaviorRelay<String> = BehaviorRelay(value: AppConstants.defaultStringValue)
    var date: BehaviorRelay<Double> = BehaviorRelay(value: AppConstants.defaultDoubleValue)
    var dismiss: PublishRelay<Void> = .init()
    var error: PublishRelay<DatabaseError> = .init()
    
    private let realmManager = RealmManager()
    private let uuid = UUID().uuidString
    private let reference = Database.database().reference()
    private let undoManager = AppDelegate.undoManager
    
    func doneButtonTapped() {
        registerNewTask()
    }
    
    private func registerNewTask() {
        let newTask = Task(
            title: title.value,
            body: body.value,
            date: date.value,
            taskType: .todo,
            id: uuid
        )
        registerAddUndoAction(task: newTask)
        
        do {
            try realmManager.create(task: newTask)
            sendNotificationForHistory(newTask.title)
            dismiss.accept(())
        } catch {
            self.error.accept(DatabaseError.createError)
        }
    }
    
    private func registerAddUndoAction(task: Task) {
        let capturedTask = Task(
            title: task.title,
            body: task.body,
            date: task.date,
            taskType: .todo,
            id: task.id
        )
        
        undoManager.registerUndo(withTarget: self) { [weak self] _ in
            self?.registerAddRedoAction(task: capturedTask)
            do {
                try self?.realmManager.delete(task: capturedTask)
                self?.sendNotificationForHistory()
            } catch {
                self?.error.accept(DatabaseError.deleteError)
            }
        }
    }
    
    private func registerAddRedoAction(task: Task) {
        let capturedTask = Task(
            title: task.title,
            body: task.body,
            date: task.date,
            taskType: .todo,
            id: task.id
        )
        
        undoManager.registerUndo(withTarget: self) { [weak self] _ in
            let title = capturedTask.title
            self?.registerAddUndoAction(task: capturedTask)
            do {
                try self?.realmManager.create(task: capturedTask)
                self?.sendNotificationForHistory(title)
            } catch {
                self?.error.accept(DatabaseError.createError)
            }
        }
    }
}
