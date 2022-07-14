//
//  EditFormSheetViewModel.swift
//  ProjectManager
//
//  Created by Donnie, Grumpy on 2022/07/11.
//

import Foundation
import RxSwift
import RxRelay

protocol EditFormSheetViewModelInput {
    func editButtonTapped(task: Task)
}

protocol EditFormSheetViewModelOutput {
    var title: BehaviorRelay<String> { get }
    var body: BehaviorRelay<String> { get }
    var date: BehaviorRelay<Double> { get }
    var dismiss: PublishRelay<Void> { get }
}

final class EditFormSheetViewModel: EditFormSheetViewModelInput, EditFormSheetViewModelOutput {
    
    var title: BehaviorRelay<String> = BehaviorRelay(value: AppConstants.defaultStringValue)
    var body: BehaviorRelay<String> = BehaviorRelay(value: AppConstants.defaultStringValue)
    var date: BehaviorRelay<Double> = BehaviorRelay(value: AppConstants.defaultDoubleValue)
    var dismiss: PublishRelay<Void> = .init()
    
    private let realmManager = RealmManager()

    func editButtonTapped(task: Task) {
        modifyEditableTask(task: task)
        dismiss.accept(())
    }
    
    func modifyEditableTask(task: Task) {
        let editableTask = Task(
            title: title.value,
            body: body.value,
            date: date.value,
            taskType: task.taskType,
            id: task.id
        )
        realmManager.update(task: editableTask)
    }
}
