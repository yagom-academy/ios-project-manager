//
//  DetailViewModel.swift
//  ProjectManager
//
//  Created by 김동욱 on 2022/07/12.
//

import Foundation

import RxCocoa
import RxSwift

final class DetailViewModel {
    private let database: DatabaseManagerProtocol
    private let notificationManager: NotificationManager

    init(database: DatabaseManagerProtocol, notificationManager: NotificationManager) {
        self.database = database
        self.notificationManager = notificationManager
    }

    func doneButtonTapEvent(
        todo: Todo?,
        selectedTodo: Todo? = nil,
        completion: @escaping () -> Void
    ){
        guard let todo = todo else {
            return
        }

        if selectedTodo != nil {
            self.database.update(selectedTodo: todo)
            self.notificationManager.updateNotification(todoData: todo)
            completion()
        } else {
            self.database.create(todoData: todo)
            self.notificationManager.setNotification(todoData: todo)
            completion()
        }
    }
}
