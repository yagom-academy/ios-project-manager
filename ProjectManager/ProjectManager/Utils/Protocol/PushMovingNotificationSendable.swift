//
//  PushNotificationSendable.swift
//  ProjectManager
//
//  Created by Donnie, Grumpy on 2022/07/28.
//

import Foundation

protocol PushMovingNotificationSendable {
    func sendNotificationForHistory()
}

extension PushMovingNotificationSendable {
    func sendNotificationForHistory(_ title: String, from beforeType: TaskType, to afterType: TaskType) {
        let content = "Moved '\(title)' from \(beforeType.rawValue) to \(afterType.rawValue)"
        let time = Date().timeIntervalSince1970
        let history: [String: Any] = [AppConstants.historyContentKey: content, AppConstants.historyTimeKey: time]
        NotificationCenter.default.post(
            name: NSNotification.Name(AppConstants.pushHistoryNotificationName),
            object: nil,
            userInfo: history
        )
    }
}
