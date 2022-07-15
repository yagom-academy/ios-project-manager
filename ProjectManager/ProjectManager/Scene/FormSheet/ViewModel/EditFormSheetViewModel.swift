//
//  EditFormSheetViewModel.swift
//  ProjectManager
//
//  Created by Donnie, Grumpy on 2022/07/11.
//

import Foundation
import RxSwift
import RxRelay

protocol EditFormSheetViewModelEvent {
    func editButtonTapped(task: Task)
}

protocol EditFormSheetViewModelState {
    var title: BehaviorRelay<String> { get }
    var body: BehaviorRelay<String> { get }
    var date: BehaviorRelay<Double> { get }
    var dismiss: PublishRelay<Void> { get }
}

final class EditFormSheetViewModel: EditFormSheetViewModelEvent, EditFormSheetViewModelState, ErrorObservable {
    
    var title: BehaviorRelay<String> = BehaviorRelay(value: AppConstants.defaultStringValue)
    var body: BehaviorRelay<String> = BehaviorRelay(value: AppConstants.defaultStringValue)
    var date: BehaviorRelay<Double> = BehaviorRelay(value: AppConstants.defaultDoubleValue)
    var dismiss: PublishRelay<Void> = .init()
    var error: PublishRelay<DatabaseError> = .init()
    
    private let realmManager = RealmManager()

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
        
        do {
            try realmManager.update(task: editableTask)
            dismiss.accept(())
        } catch {
            self.error.accept(DatabaseError.updateError)
        }
    }
}
