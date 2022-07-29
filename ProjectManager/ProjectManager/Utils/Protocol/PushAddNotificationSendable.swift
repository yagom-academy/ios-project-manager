//
//  PushAddNotificationSendable.swift
//  ProjectManager
//
//  Created by Donnie, Grumpy on 2022/07/28.
//

import Foundation

protocol PushAddNotificationSendable {
    func sendNotificationForHistory()
}

extension PushAddNotificationSendable {
    func sendNotificationForHistory(_ title: String) {
        let content = "Added '\(title)'."
        let time = Date().timeIntervalSince1970
        let history: [String: Any] = [AppConstants.historyContentKey: content, AppConstants.historyTimeKey: time]
        NotificationCenter.default.post(
            name: NSNotification.Name(AppConstants.pushHistoryNotificationName),
            object: nil,
            userInfo: history
        )
    }
}
