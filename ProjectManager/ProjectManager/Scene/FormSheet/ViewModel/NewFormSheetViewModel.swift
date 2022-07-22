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

final class NewFormSheetViewModel: NewFormSheetViewModelEvent, NewFormSheetViewModelState, ErrorObservable {
    
    var title: BehaviorRelay<String> = BehaviorRelay(value: AppConstants.defaultStringValue)
    var body: BehaviorRelay<String> = BehaviorRelay(value: AppConstants.defaultStringValue)
    var date: BehaviorRelay<Double> = BehaviorRelay(value: AppConstants.defaultDoubleValue)
    var dismiss: PublishRelay<Void> = .init()
    var error: PublishRelay<DatabaseError> = .init()
    
    private let realmManager = RealmManager()
    private let uuid = UUID().uuidString
    private let reference = Database.database().reference()
    
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

        do {
            try realmManager.create(task: newTask)
            
            let historyTitle = "Added '\(title.value)'"
            let historyTime = date.value
            let dic: [String: Any] = ["title": historyTitle, "time": historyTime]
            NotificationCenter.default.post(name: NSNotification.Name("Append"), object: nil, userInfo: dic)
            
            dismiss.accept(())
        } catch {
            self.error.accept(DatabaseError.createError)
        }
    }
}
