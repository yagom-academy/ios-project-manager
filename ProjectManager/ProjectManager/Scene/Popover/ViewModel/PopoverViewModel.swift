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

final class PopoverViewModel: PopoverViewModelEvent, PopoverViewModelState, ErrorObservable {
    
    var dismiss: PublishRelay<Void> = .init()
    var error: PublishRelay<DatabaseError> = .init()
    
    private let realmManager = RealmManager()
    private let reference = Database.database().reference()
    
    func moveButtonTapped(_ task: Task, to taskType: TaskType) {
        changeTaskType(task, taskType: taskType)
    }

    private func changeTaskType(_ task: Task, taskType: TaskType) {
        let beforeType = task.taskType
        
        do {
            try realmManager.change(task: task, targetType: taskType)
            
            let historyTitle = "Moved '\(task.title)' from \(beforeType.rawValue) to \(taskType.rawValue)"
            let historyTime = Date().timeIntervalSince1970
            let dic: [String: Any] = ["title": historyTitle, "time": historyTime]
            NotificationCenter.default.post(name: NSNotification.Name("Append"), object: nil, userInfo: dic)
            
            dismiss.accept(())
        } catch {
            self.error.accept(DatabaseError.changeError)
        }
    }
}
