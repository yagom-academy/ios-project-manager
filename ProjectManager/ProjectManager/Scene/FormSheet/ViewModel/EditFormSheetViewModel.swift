//
//  EditFormSheetViewModel.swift
//  ProjectManager
//
//  Created by Donnie, Grumpy on 2022/07/11.
//

import Foundation
import RxSwift
import RxRelay
import Firebase

protocol EditFormSheetViewModelEvent {
    func editButtonTapped(task: Task)
}

protocol EditFormSheetViewModelState {
    var title: BehaviorRelay<String> { get }
    var body: BehaviorRelay<String> { get }
    var date: BehaviorRelay<Double> { get }
    var dismiss: PublishRelay<Void> { get }
}

final class EditFormSheetViewModel: EditFormSheetViewModelEvent,
                                        EditFormSheetViewModelState,
                                        ErrorObservable {
    
    var title: BehaviorRelay<String> = BehaviorRelay(value: AppConstants.defaultStringValue)
    var body: BehaviorRelay<String> = BehaviorRelay(value: AppConstants.defaultStringValue)
    var date: BehaviorRelay<Double> = BehaviorRelay(value: AppConstants.defaultDoubleValue)
    var dismiss: PublishRelay<Void> = .init()
    var error: PublishRelay<DatabaseError> = .init()
    
    private let reference = Database.database().reference()
    private let realmManager = RealmManager()
    private let undoManager = AppDelegate.undoManager
    
    func editButtonTapped(task: Task) {
        modifyEditableTask(task: task)
    }
    
    func modifyEditableTask(task: Task) {
        let editableTask = Task(
            title: title.value,
            body: body.value,
            date: date.value,
            taskType: task.taskType,
            id: task.id
        )
        let capturedOriginalTask = Task(
            title: task.title,
            body: task.body,
            date: task.date,
            taskType: task.taskType,
            id: task.id
        )
        let capturedEditedTask = Task(
            title: title.value,
            body: body.value,
            date: date.value,
            taskType: task.taskType,
            id: task.id
        )
        registerModifyUndoAction(
            before: capturedOriginalTask,
            after: capturedEditedTask
        )
        do {
            try realmManager.update(task: editableTask)
            dismiss.accept(())
        } catch {
            self.error.accept(DatabaseError.updateError)
        }
    }
    
    private func registerModifyUndoAction(before: Task, after: Task) {
        let capturedOriginalTask = Task(
            title: before.title,
            body: before.body,
            date: before.date,
            taskType: before.taskType,
            id: before.id
        )
        let capturedEditedTask = Task(
            title: after.title,
            body: after.body,
            date: after.date,
            taskType: after.taskType,
            id: after.id
        )
        undoManager.registerUndo(withTarget: self) { [weak self] _ in
            self?.registerModifyRedoAction(
                before: capturedEditedTask,
                after: capturedOriginalTask
            )
            do {
                try self?.realmManager.update(task: before)
            } catch {
                self?.error.accept(DatabaseError.updateError)
            }
        }
    }
    
    private func registerModifyRedoAction(before: Task, after: Task) {
        let capturedOriginalTask = Task(
            title: before.title,
            body: before.body,
            date: before.date,
            taskType: before.taskType,
            id: before.id
        )
        let capturedEditedTask = Task(
            title: after.title,
            body: after.body,
            date: after.date,
            taskType: after.taskType,
            id: after.id
        )
        undoManager.registerUndo(withTarget: self) { [weak self] _ in
            self?.registerModifyUndoAction(
                before: capturedEditedTask,
                after: capturedOriginalTask
            )
            do {
                try self?.realmManager.update(task: before)
            } catch {
                self?.error.accept(DatabaseError.updateError)
            }
        }
    }
}
