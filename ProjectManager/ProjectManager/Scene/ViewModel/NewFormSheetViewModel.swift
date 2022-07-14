//
//  NewFormSheetViewModel.swift
//  ProjectManager
//
//  Created by Donnie, Grumpy on 2022/07/11.
//

import Foundation
import RxSwift
import RxRelay

protocol NewFormSheetViewModelInput {
    func doneButtonTapped()
}

protocol NewFormSheetViewModelOutput {
    var title: BehaviorRelay<String> { get }
    var body: BehaviorRelay<String> { get }
    var date: BehaviorRelay<Double> { get }
    var dismiss: PublishRelay<Void> { get }
}

final class NewFormSheetViewModel: NewFormSheetViewModelInput, NewFormSheetViewModelOutput {
    
    var title: BehaviorRelay<String> = BehaviorRelay(value: AppConstants.defaultStringValue)
    var body: BehaviorRelay<String> = BehaviorRelay(value: AppConstants.defaultStringValue)
    var date: BehaviorRelay<Double> = BehaviorRelay(value: AppConstants.defaultDoubleValue)
    var dismiss: PublishRelay<Void> = .init()
    
    private let realmManager = RealmManager()
    private let uuid = UUID().uuidString
    
    func doneButtonTapped() {
        registerNewTask()
        dismiss.accept(())
    }
    
    private func registerNewTask() {
        let newTask = Task(
            title: title.value,
            body: body.value,
            date: date.value,
            taskType: .todo,
            id: uuid
        )
        realmManager.create(task: newTask)
    }
}
