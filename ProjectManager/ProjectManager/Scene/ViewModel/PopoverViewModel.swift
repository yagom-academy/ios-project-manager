//
//  PopoverViewModel.swift
//  ProjectManager
//
//  Created by Donnie, Grumpy on 2022/07/11.
//

import Foundation
import RxRelay

protocol PopoverViewModelInput {
    func moveButtonTapped(_ task: Task, to taskType: TaskType)
}

protocol PopoverViewModelOutput {
    var dismiss: PublishRelay<Void> { get }
}

final class PopoverViewModel: PopoverViewModelInput, PopoverViewModelOutput {
    
    var dismiss: PublishRelay<Void> = .init()
    
    private let realmManager = RealmManager()
    
    func moveButtonTapped(_ task: Task, to taskType: TaskType) {
        changeTaskType(task, taskType: taskType)
        dismiss.accept(())
    }

    private func changeTaskType(_ task: Task, taskType: TaskType) {
        realmManager.change(task: task, targetType: taskType)
    }
}
