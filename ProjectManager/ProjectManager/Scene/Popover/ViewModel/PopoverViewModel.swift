//
//  PopoverViewModel.swift
//  ProjectManager
//
//  Created by Donnie, Grumpy on 2022/07/11.
//

import Foundation
import RxRelay

protocol PopoverViewModelEvent {
    func moveButtonTapped(_ task: Task, to taskType: TaskType)
}

protocol PopoverViewModelState {
    var dismiss: PublishRelay<Void> { get }
}

final class PopoverViewModel: PopoverViewModelEvent, PopoverViewModelState, ErrorObservable {
    
    var dismiss: PublishRelay<Void> = .init()
    var error: PublishRelay<DatabaseError> = .init()
    
    private let realmManager = RealmManager()
    
    func moveButtonTapped(_ task: Task, to taskType: TaskType) {
        changeTaskType(task, taskType: taskType)
    }

    private func changeTaskType(_ task: Task, taskType: TaskType) {
        do {
            try realmManager.change(task: task, targetType: taskType)
            dismiss.accept(())
        } catch {
            self.error.accept(DatabaseError.changeError)
        }
    }
}
